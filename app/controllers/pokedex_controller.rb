# ポケモン図鑑コントローラー 📖
# JSONベースのポケモンデータを表示・検索する機能を提供
class PokedexController < ApplicationController
  before_action :set_pokemon_species, only: [:show]

  # ポケモン図鑑一覧ページ 📝
  def index
    @pokemon_species = PokemonSpecies.all
    @pokemon_species = filter_by_search if params[:search].present?
    @pokemon_species = filter_by_type if params[:type].present?
    @pokemon_species = filter_by_generation if params[:generation].present?
    @pokemon_species = @pokemon_species.order(:national_id)
    
    # ページネーション（1ページ30匹）
    @pokemon_species = @pokemon_species.page(params[:page]).per(30)
    
    # 統計情報（キャッシュ化で最適化）
    @total_species = Rails.cache.fetch("pokemon_species_count", expires_in: 1.hour) do
      PokemonSpecies.count
    end
    
    @generations = Rails.cache.fetch("pokemon_generations", expires_in: 1.hour) do
      PokemonSpecies.pluck_generations.uniq.sort
    end
    
    @types = Rails.cache.fetch("pokemon_types", expires_in: 1.hour) do
      PokemonSpecies.pluck_types.uniq.sort
    end
  end

  # ポケモン詳細ページ 🔍
  def show
    @moves = @pokemon_species.moves_data&.first(20) # 最初の20個の技を表示
    @stats = @pokemon_species.stats_data
    @abilities = @pokemon_species.abilities_data
  end

  # ランダムポケモン表示 🎲
  def random
    @pokemon_species = PokemonSpecies.order('RANDOM()').first
    if @pokemon_species
      redirect_to pokedex_path(@pokemon_species)
    else
      redirect_to pokedex_index_path, alert: 'ポケモンデータが見つかりません 😢'
    end
  end

  # API: ポケモン検索（AJAX用） ⚡
  def search
    @pokemon_species = PokemonSpecies.search_by_name(params[:q])
    render json: @pokemon_species.limit(10).select(:id, :name_ja, :name_en, :national_id)
  end

  private

  def set_pokemon_species
    @pokemon_species = PokemonSpecies.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to pokedex_index_path, alert: 'ポケモンが見つかりません 😢'
  end

  def filter_by_search
    @pokemon_species.search_by_name(params[:search])
  end

  def filter_by_type
    @pokemon_species.filter_by_type(params[:type])
  end

  def filter_by_generation
    @pokemon_species.filter_by_generation(params[:generation])
  end
end
