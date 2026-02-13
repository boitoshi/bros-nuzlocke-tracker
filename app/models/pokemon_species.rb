# ポケモン種族データモデル 🐾
# JSONベースのポケモン図鑑データを管理
class PokemonSpecies < ApplicationRecord
  # バリデーション
  validates :national_id, presence: true, uniqueness: true
  validates :name_ja, presence: true
  validate :validate_generation_in_data
  
  # スコープ（generation/is_legendary/is_mythicalはdataカラムのJSON内に格納）
  scope :by_generation, ->(gen) {
    if connection.adapter_name == 'PostgreSQL'
      where("data ->> 'generation' = ?", gen.to_s)
    else
      where("json_extract(data, '$.generation') = ?", gen)
    end
  }
  scope :by_type, ->(type) {
    if connection.adapter_name == 'PostgreSQL'
      where("data -> 'types' @> ?", [type].to_json)
    else
      where("json_extract(data, '$.types') LIKE ?", "%#{type}%")
    end
  }
  scope :legendary, -> {
    if connection.adapter_name == 'PostgreSQL'
      where("(data ->> 'is_legendary')::boolean = true")
    else
      where("json_extract(data, '$.is_legendary') = 1")
    end
  }
  scope :mythical, -> {
    if connection.adapter_name == 'PostgreSQL'
      where("(data ->> 'is_mythical')::boolean = true")
    else
      where("json_extract(data, '$.is_mythical') = 1")
    end
  }
  scope :regular, -> {
    if connection.adapter_name == 'PostgreSQL'
      where("((data ->> 'is_legendary')::boolean IS NOT TRUE) AND ((data ->> 'is_mythical')::boolean IS NOT TRUE)")
    else
      where("(json_extract(data, '$.is_legendary') IS NULL OR json_extract(data, '$.is_legendary') != 1) AND (json_extract(data, '$.is_mythical') IS NULL OR json_extract(data, '$.is_mythical') != 1)")
    end
  }
  
  # 検索スコープ 🔍（SQLite/PostgreSQL両対応）
  scope :search_by_name, ->(query) {
    sanitized = "%#{sanitize_sql_like(query)}%"
    if connection.adapter_name == 'PostgreSQL'
      where("name_ja ILIKE ? OR name_en ILIKE ? OR name_kana ILIKE ?",
            sanitized, sanitized, sanitized)
    else
      where("name_ja LIKE ? OR name_en LIKE ? OR name_kana LIKE ?",
            sanitized, sanitized, sanitized)
    end
  }

  scope :filter_by_type, ->(type) {
    if connection.adapter_name == 'PostgreSQL'
      where("data -> 'types' @> ?", [type].to_json)
    else
      where("json_extract(data, '$.types') LIKE ?", "%#{type}%")
    end
  }

  scope :filter_by_generation, ->(gen) {
    if connection.adapter_name == 'PostgreSQL'
      where("data ->> 'generation' = ?", gen.to_s)
    else
      where("json_extract(data, '$.generation') = ?", gen)
    end
  }

  # メソッド
  # JSONデータから特定の情報を取得するヘルパーメソッド ✨
  def types_data
    data&.dig('types') || []
  end

  def stats_data
    data&.dig('stats') || {}
  end

  def abilities_data
    data&.dig('abilities') || []
  end

  def moves_data
    data&.dig('moves') || []
  end

  def evolution_data
    data&.dig('evolution') || {}
  end

  def generation
    data&.dig('generation') || 1
  end

  def height_m
    data&.dig('height')&.to_f&./(10) # dmをmに変換
  end

  def weight_kg
    data&.dig('weight')&.to_f&./(10) # hgをkgに変換
  end

  def sprite_url
    return nil unless national_id
    
    # Pokemon APIの公式スプライト画像URL
    "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/#{national_id}.png"
  end

  def official_artwork_url
    return nil unless national_id
    
    # 高解像度の公式アートワーク
    "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/#{national_id}.png"
  end

  def shiny_sprite_url
    return nil unless national_id
    
    # 色違いスプライト
    "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/#{national_id}.png"
  end

  # タイプの色を取得 🌈
  def type_colors
    types_data.map { |type| type_color(type) }
  end

  # クラスメソッド: 全世代のリストを取得
  def self.pluck_generations
    pluck("DISTINCT data ->> 'generation'").compact.map(&:to_i)
  end

  # クラスメソッド: 全タイプのリストを取得
  def self.pluck_types
    connection.execute(
      "SELECT DISTINCT jsonb_array_elements_text(data -> 'types') as type_name FROM pokemon_species"
    ).pluck('type_name').compact
  end

  # 表示用名前（日本語優先）
  def display_name
    name_ja.presence || name_en || "不明なポケモン"
  end

  # 図鑑番号をゼロ埋めで表示
  def formatted_dex_number
    "##{national_id.to_s.rjust(3, '0')}"
  end

  private

  # generationをdata JSON内から検証するカスタムバリデーション
  def validate_generation_in_data
    gen = data&.dig('generation')
    if gen.nil?
      errors.add(:base, '世代情報(generation)がdataに含まれていません')
    elsif !(1..9).include?(gen.to_i)
      errors.add(:base, '世代情報(generation)は1〜9の範囲で指定してください')
    end
  end

  def type_color(type_name)
    case type_name&.downcase
    when 'normal' then '#A8A878'
    when 'fire', 'ほのお' then '#F08030'
    when 'water', 'みず' then '#6890F0'
    when 'electric', 'でんき' then '#F8D030'
    when 'grass', 'くさ' then '#78C850'
    when 'ice', 'こおり' then '#98D8D8'
    when 'fighting', 'かくとう' then '#C03028'
    when 'poison', 'どく' then '#A040A0'
    when 'ground', 'じめん' then '#E0C068'
    when 'flying', 'ひこう' then '#A890F0'
    when 'psychic', 'エスパー' then '#F85888'
    when 'bug', 'むし' then '#A8B820'
    when 'rock', 'いわ' then '#B8A038'
    when 'ghost', 'ゴースト' then '#705898'
    when 'dragon', 'ドラゴン' then '#7038F8'
    when 'dark', 'あく' then '#705848'
    when 'steel', 'はがね' then '#B8B8D0'
    when 'fairy', 'フェアリー' then '#EE99AC'
    else '#68A090'
    end
  end
end
