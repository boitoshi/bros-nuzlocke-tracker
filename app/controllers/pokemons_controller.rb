class PokemonsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_challenge
  before_action :set_pokemon, only: [ :show, :edit, :update, :destroy, :toggle_party, :mark_as_dead, :mark_as_boxed ]

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
  end

  def edit
    @areas = Area.by_game(@challenge.game_title).by_order
  end

  def create
    @pokemon = @challenge.pokemons.build(pokemon_params)
    @pokemon.caught_at = Time.current
    @pokemon.status = :alive

    begin
      if @pokemon.save
        redirect_to challenge_pokemon_path(@challenge, @pokemon), notice: t("pokemons.notices.created", pokemon: @pokemon.display_name)
      else
        @areas = Area.by_game(@challenge.game_title).by_order
        render :new, status: :unprocessable_entity
      end
    rescue ActiveRecord::RecordInvalid => e
      Rails.logger.error "Pokemon creation failed: #{e.message}"
      @areas = Area.by_game(@challenge.game_title).by_order
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
