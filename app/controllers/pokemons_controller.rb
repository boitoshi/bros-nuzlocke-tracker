class PokemonsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_challenge
  before_action :set_pokemon, only: [ :show, :edit, :update, :destroy, :toggle_party, :mark_as_dead, :mark_as_boxed, :update_level, :evolve ]

  def index
    @pokemons = @challenge.pokemons.includes(:area).by_caught_order
    @party_pokemon = @challenge.party_pokemon
    @alive_pokemon = @challenge.alive_pokemon.not_in_party
    @dead_pokemon = @challenge.dead_pokemon
    @boxed_pokemon = @challenge.boxed_pokemon
  end

  def party
    @party_pokemon = @challenge.party_pokemon.includes(:area)
    @available_pokemon = @challenge.alive_pokemon.not_in_party.includes(:area)
  end

  def show
  end

  def new
    @pokemon = @challenge.pokemons.build
    @areas = Area.by_game(@challenge.game_title).by_order

    # ゲーム用のエリアがない場合は作成
    if @areas.empty?
      @challenge.create_areas_for_game
      @areas = Area.by_game(@challenge.game_title).by_order
    end

    # 捕獲済みエリア情報（ナズロックルール判定用）
    @caught_areas = @challenge.pokemons.includes(:area).each_with_object({}) do |pokemon, hash|
      hash[pokemon.area_id] = { name: pokemon.display_name, status: pokemon.status }
    end
  end

  def edit
    @areas = Area.by_game(@challenge.game_title).by_order
    # 捕獲済みエリア情報（自分自身は除外）
    @caught_areas = @challenge.pokemons.where.not(id: @pokemon.id).includes(:area).each_with_object({}) do |pokemon, hash|
      hash[pokemon.area_id] = { name: pokemon.display_name, status: pokemon.status }
    end
  end

  def create
    @pokemon = @challenge.pokemons.build(pokemon_params)
    @pokemon.caught_at = Time.current
    @pokemon.status = :alive

    begin
      if @pokemon.save
        if params[:continue_capture].present?
          redirect_to new_challenge_pokemon_path(@challenge), notice: "#{@pokemon.display_name}を捕獲！ 続けて次のポケモンを捕獲しよう✨"
        else
          redirect_to challenge_pokemon_path(@challenge, @pokemon), notice: t("pokemons.notices.created", pokemon: @pokemon.display_name)
        end
      else
        @areas = Area.by_game(@challenge.game_title).by_order
        @caught_areas = @challenge.pokemons.includes(:area).each_with_object({}) do |pokemon, hash|
          hash[pokemon.area_id] = { name: pokemon.display_name, status: pokemon.status }
        end
        render :new, status: :unprocessable_entity
      end
    rescue ActiveRecord::RecordInvalid => e
      Rails.logger.error "Pokemon creation failed: #{e.message}"
      @areas = Area.by_game(@challenge.game_title).by_order
      @caught_areas = @challenge.pokemons.includes(:area).each_with_object({}) do |pokemon, hash|
        hash[pokemon.area_id] = { name: pokemon.display_name, status: pokemon.status }
      end
      flash.now[:alert] = "ポケモンの作成に失敗しました。入力内容を確認してください。"
      render :new, status: :unprocessable_entity
    rescue StandardError => e
      Rails.logger.error "Unexpected error during pokemon creation: #{e.message}"
      redirect_to new_challenge_pokemon_path(@challenge), alert: "予期しないエラーが発生しました。しばらく時間をおいて再度お試しください。"
    end
  end

  def update
    begin
      if @pokemon.update(pokemon_params)
        redirect_to challenge_pokemon_path(@challenge, @pokemon), notice: t("pokemons.notices.updated")
      else
        @areas = Area.by_game(@challenge.game_title).by_order
        render :edit, status: :unprocessable_entity
      end
    rescue ActiveRecord::RecordInvalid => e
      Rails.logger.error "Pokemon update failed: #{e.message}"
      @areas = Area.by_game(@challenge.game_title).by_order
      flash.now[:alert] = "ポケモンの更新に失敗しました。入力内容を確認してください。"
      render :edit, status: :unprocessable_entity
    rescue StandardError => e
      Rails.logger.error "Unexpected error during pokemon update: #{e.message}"
      redirect_to challenge_pokemon_path(@challenge, @pokemon), alert: "予期しないエラーが発生しました。しばらく時間をおいて再度お試しください。"
    end
  end

  def destroy
    pokemon_name = @pokemon.display_name
    @pokemon.destroy
    redirect_to challenge_pokemons_path(@challenge), notice: "#{pokemon_name}の記録を削除しました。"
  end

  def toggle_party
    if @pokemon.in_party?
      @pokemon.update(in_party: false)
      redirect_back_or_to party_challenge_pokemons_path(@challenge), notice: "#{@pokemon.display_name}をパーティから外しました。"
    elsif @challenge.can_add_to_party? && @pokemon.can_be_in_party?
      @pokemon.update(in_party: true)
      redirect_back_or_to party_challenge_pokemons_path(@challenge), notice: "#{@pokemon.display_name}をパーティに加えました！"
    else
      redirect_back_or_to party_challenge_pokemons_path(@challenge), alert: "パーティに追加できませんでした。"
    end
  end

  def mark_as_dead
    @pokemon.update(status: :dead, died_at: Time.current, in_party: false)
    redirect_back_or_to challenge_pokemon_path(@challenge, @pokemon),
                        notice: "#{@pokemon.display_name}が死亡しました...安らかに眠ってください 😢"
  end

  def mark_as_boxed
    @pokemon.update(status: :boxed, in_party: false)
    redirect_back_or_to challenge_pokemon_path(@challenge, @pokemon),
                        notice: "#{@pokemon.display_name}をボックスに預けました。"
  end

  def update_level
    old_level = @pokemon.level
    new_level = params[:level].to_i

    if new_level.between?(1, 100) && @pokemon.update(level: new_level)
      if new_level > old_level
        EventLog.log_level_up(@challenge, @pokemon, old_level, new_level)
      end
      redirect_back_or_to party_challenge_pokemons_path(@challenge),
                          notice: "#{@pokemon.nickname} Lv.#{old_level} → Lv.#{new_level} 📈"
    else
      redirect_back_or_to party_challenge_pokemons_path(@challenge),
                          alert: "レベルは1〜100の範囲で設定してください。"
    end
  end

  def evolve
    old_species = @pokemon.species
    new_species = params[:new_species]&.strip

    if new_species.present? && new_species != old_species && @pokemon.update(species: new_species)
      EventLog.create!(
        challenge: @challenge,
        pokemon: @pokemon,
        event_type: :pokemon_evolved,
        title: "#{@pokemon.nickname}が進化！",
        description: "#{old_species} → #{new_species}",
        occurred_at: Time.current,
        importance: 3,
        event_data: { from: old_species, to: new_species, nickname: @pokemon.nickname, level: @pokemon.level }
      )
      redirect_back_or_to challenge_pokemon_path(@challenge, @pokemon),
                          notice: "#{@pokemon.nickname}が#{old_species}から#{new_species}に進化した！✨"
    else
      redirect_back_or_to challenge_pokemon_path(@challenge, @pokemon),
                          alert: "進化に失敗しました。新しい種族名を入力してください。"
    end
  end

  private

  def set_challenge
    @challenge = current_user.challenges.find(params[:challenge_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to challenges_path, alert: "指定されたチャレンジが見つかりません。"
  end

  def set_pokemon
    @pokemon = @challenge.pokemons.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to challenge_pokemons_path(@challenge), alert: "指定されたポケモンが見つかりません。"
  end

  def pokemon_params
    params.expect(pokemon: [ 
      :nickname, :species, :level, :nature, :ability, :area_id, :experience, :in_party, 
      :primary_type, :secondary_type, :role, :gender, :notes,
      # Individual Values (IVs)
      :hp_iv, :attack_iv, :defense_iv, :special_attack_iv, :special_defense_iv, :speed_iv,
      # Effort Values (EVs)
      :hp_ev, :attack_ev, :defense_ev, :special_attack_ev, :special_defense_ev, :speed_ev
    ])
  end

  def redirect_back_or_to(fallback_path, **options)
    redirect_to((request.referer.presence || fallback_path), **options)
  end
end
