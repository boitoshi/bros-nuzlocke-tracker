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

  def create
    @pokemon = @challenge.pokemons.build(pokemon_params)
    @pokemon.caught_at = Time.current
    @pokemon.status = :alive

    if @pokemon.save
      redirect_to challenge_pokemons_path(@challenge), notice: "#{@pokemon.display_name}を捕獲しました！ 🎉"
    else
      @areas = Area.by_game(@challenge.game_title).by_order
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @areas = Area.by_game(@challenge.game_title).by_order
  end

  def update
    if @pokemon.update(pokemon_params)
      redirect_to challenge_pokemon_path(@challenge, @pokemon), notice: "ポケモン情報が更新されました！"
    else
      @areas = Area.by_game(@challenge.game_title).by_order
      render :edit, status: :unprocessable_entity
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
      redirect_back_or_to challenge_pokemons_party_path(@challenge), notice: "#{@pokemon.display_name}をパーティから外しました。"
    elsif @challenge.can_add_to_party? && @pokemon.can_be_in_party?
      @pokemon.update(in_party: true)
      redirect_back_or_to challenge_pokemons_party_path(@challenge), notice: "#{@pokemon.display_name}をパーティに加えました！"
    else
      redirect_back_or_to challenge_pokemons_party_path(@challenge), alert: "パーティに追加できませんでした。"
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
  end

  def set_pokemon
    @pokemon = @challenge.pokemons.find(params[:id])
  end

  def pokemon_params
    params.require(:pokemon).permit(:nickname, :species, :level, :nature, :ability, :area_id, :experience, :in_party)
  end

  def redirect_back_or_to(fallback_path, **options)
    redirect_to(request.referer.present? ? request.referer : fallback_path, **options)
  end
end
