class BattleRecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_challenge
  before_action :set_battle_record, only: [:show, :edit, :update, :participants]

  def index
    @battle_records = @challenge.battle_records
                              .recent
                              .includes(:mvp_pokemon, :boss_battle, :participating_pokemon)
                              .limit(20)
    
    # フィルタリング
    @battle_records = @battle_records.by_battle_type(params[:battle_type]) if params[:battle_type].present?
    @battle_records = @battle_records.where(result: params[:result]) if params[:result].present?
    
    @battle_statistics = @challenge.battle_statistics
  end

  def show
    @participants = @battle_record.battle_participants
                                 .includes(:pokemon)
                                 .order(:created_at)
  end

  def new
    @battle_record = @challenge.battle_records.build
    @battle_record.battle_date = Time.current
    @battle_record.difficulty_rating = 3
    
    # 利用可能なポケモンとボス戦情報を取得
    @available_pokemon = @challenge.pokemons.alive_pokemon.order(:nickname)
    @boss_battles = BossBattle.where(game_title: @challenge.game_title).order(:name)
    
    # 選択されたボス戦がある場合は情報を設定
    if params[:boss_battle_id].present?
      @selected_boss = @boss_battles.find_by(id: params[:boss_battle_id])
      if @selected_boss
        @battle_record.boss_battle = @selected_boss
        @battle_record.opponent_name = @selected_boss.name
        @battle_record.battle_type = @selected_boss.boss_type
        @battle_record.location = @selected_boss.area&.name
        @battle_record.difficulty_rating = @selected_boss.difficulty || 3
      end
    end
  end

  def create
    @battle_record = @challenge.battle_records.build(battle_record_params)
    
    if @battle_record.save
      # 参加ポケモンの情報を作成
      create_battle_participants if participant_params_present?
      
      redirect_to challenge_battle_record_path(@challenge, @battle_record), 
                  notice: '⚔️ バトル記録が正常に作成されました！'
    else
      @available_pokemon = @challenge.pokemons.alive_pokemon.order(:nickname)
      @boss_battles = BossBattle.where(game_title: @challenge.game_title).order(:name)
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @available_pokemon = @challenge.pokemons.order(:nickname)
    @boss_battles = BossBattle.where(game_title: @challenge.game_title).order(:name)
  end

  def update
    if @battle_record.update(battle_record_params)
      # 参加ポケモン情報の更新
      update_battle_participants if participant_params_present?
      
      redirect_to challenge_battle_record_path(@challenge, @battle_record), 
                  notice: '⚔️ バトル記録が正常に更新されました！'
    else
      @available_pokemon = @challenge.pokemons.order(:nickname)
      @boss_battles = BossBattle.where(game_title: @challenge.game_title).order(:name)
      render :edit, status: :unprocessable_entity
    end
  end

  def participants
    # バトル参加ポケモンの詳細ページ
    @participants = @battle_record.battle_participants
                                 .includes(:pokemon)
                                 .order(:performance_rating).reverse_order
  end

  private

  def set_challenge
    @challenge = current_user.challenges.find(params[:challenge_id])
  end

  def set_battle_record
    @battle_record = @challenge.battle_records.find(params[:id])
  end

  def battle_record_params
    params.require(:battle_record).permit(
      :battle_type, :result, :battle_date, :location, :opponent_name,
      :battle_notes, :total_turns, :experience_gained, :difficulty_rating,
      :boss_battle_id, :mvp_pokemon_id,
      opponent_data: {},
      casualties: []
    )
  end

  def participant_params_present?
    params[:battle_participants].present?
  end

  def create_battle_participants
    return unless params[:battle_participants].present?
    
    ActiveRecord::Base.transaction do
      params[:battle_participants].each do |participant_data|
        next unless participant_data[:pokemon_id].present?
        
        begin
          pokemon = @challenge.pokemons.find(participant_data[:pokemon_id])
          
          @battle_record.battle_participants.create!(
            pokemon: pokemon,
            starting_level: participant_data[:starting_level] || pokemon.level,
            ending_level: participant_data[:ending_level] || pokemon.level,
            starting_hp: participant_data[:starting_hp] || 0,
            ending_hp: participant_data[:ending_hp] || 0,
            turns_active: participant_data[:turns_active] || 0,
            damage_dealt: participant_data[:damage_dealt] || 0,
            damage_taken: participant_data[:damage_taken] || 0,
            was_ko: participant_data[:was_ko] == '1',
            performance_notes: participant_data[:performance_notes],
            moves_used: parse_moves_used(participant_data[:moves_used])
          )
        rescue ActiveRecord::RecordNotFound
          Rails.logger.warn "Pokemon with ID #{participant_data[:pokemon_id]} not found for battle record #{@battle_record.id}"
          next
        end
      end
    end
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error "Failed to create battle participants: #{e.message}"
    @battle_record.errors.add(:base, "参加ポケモンの登録に失敗しました: #{e.message}")
    false
  rescue StandardError => e
    Rails.logger.error "Unexpected error during battle participants creation: #{e.message}"
    @battle_record.errors.add(:base, "予期しないエラーが発生しました")
    false
  end

  def update_battle_participants
    return unless params[:battle_participants].present?
    
    # 既存の参加記録を削除
    @battle_record.battle_participants.destroy_all
    
    # 新しい参加記録を作成
    create_battle_participants
  end

  def parse_moves_used(moves_string)
    return [] if moves_string.blank?
    
    # カンマ区切りの文字列を配列に変換
    moves_string.split(',').map(&:strip).reject(&:blank?)
  end
end
