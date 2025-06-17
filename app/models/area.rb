class Area < ApplicationRecord
  has_many :pokemons, dependent: :destroy

  # エリアタイプの定義
  enum area_type: {
    route: 0,         # ルート
    city: 1,          # 街・町
    gym: 2,           # ジム
    cave: 3,          # 洞窟
    forest: 4,        # 森
    tower: 5,         # タワー
    building: 6,      # 建物
    water: 7,         # 水上
    special: 8        # 特殊エリア
  }

  # バリデーション
  validates :name, presence: true, length: { minimum: 1, maximum: 100 }
  validates :area_type, presence: true
  validates :game_title, presence: true, inclusion: { in: Challenge::GAME_TITLES.map(&:last) }
  validates :order_index, presence: true, numericality: { greater_than_or_equal_to: 0 }

  # スコープ
  scope :by_game, ->(game) { where(game_title: game) }
  scope :by_order, -> { order(:order_index) }
  scope :routes_only, -> { where(area_type: :route) }
  scope :gyms_only, -> { where(area_type: :gym) }

  # メソッド
  def area_type_display
    case area_type
    when 'route' then 'ルート'
    when 'city' then '街・町'
    when 'gym' then 'ジム'
    when 'cave' then '洞窟'
    when 'forest' then '森'
    when 'tower' then 'タワー'
    when 'building' then '建物'
    when 'water' then '水上'
    when 'special' then '特殊エリア'
    else area_type
    end
  end

  def area_type_icon
    case area_type
    when 'route' then '🛤️'
    when 'city' then '🏘️'
    when 'gym' then '🏟️'
    when 'cave' then '🕳️'
    when 'forest' then '🌲'
    when 'tower' then '🗼'
    when 'building' then '🏢'
    when 'water' then '🌊'
    when 'special' then '✨'
    else '📍'
    end
  end

  def display_name
    "#{area_type_icon} #{name}"
  end

  def has_caught_pokemon_for_challenge?(challenge)
    pokemons.where(challenge: challenge).exists?
  end

  def caught_pokemon_for_challenge(challenge)
    pokemons.where(challenge: challenge).first
  end

  # ゲーム別のデフォルトエリアデータを作成するクラスメソッド
  def self.create_default_areas_for_game(game_title)
    return if exists?(game_title: game_title)

    case game_title
    when 'red', 'green', 'blue', 'yellow'
      create_kanto_areas(game_title)
    when 'gold', 'silver', 'crystal'
      create_johto_areas(game_title)
    # 他のゲームも追加可能
    end
  end

  private

  def self.create_kanto_areas(game_title)
    areas = [
      { name: 'ルート1', area_type: :route, order_index: 1 },
      { name: 'ルート2', area_type: :route, order_index: 2 },
      { name: 'トキワの森', area_type: :forest, order_index: 3 },
      { name: 'ルート3', area_type: :route, order_index: 4 },
      { name: 'ルート4', area_type: :route, order_index: 5 },
      { name: 'ルート5', area_type: :route, order_index: 6 },
      { name: 'ルート6', area_type: :route, order_index: 7 },
      { name: 'ルート7', area_type: :route, order_index: 8 },
      { name: 'ルート8', area_type: :route, order_index: 9 },
      { name: 'ルート9', area_type: :route, order_index: 10 },
      { name: 'ルート10', area_type: :route, order_index: 11 },
      { name: 'ニビジム', area_type: :gym, order_index: 12 },
      { name: 'ハナダジム', area_type: :gym, order_index: 13 },
      { name: 'クチバジム', area_type: :gym, order_index: 14 },
      { name: 'タマムシジム', area_type: :gym, order_index: 15 },
      { name: 'ヤマブキジム', area_type: :gym, order_index: 16 },
      { name: 'セキチクジム', area_type: :gym, order_index: 17 },
      { name: 'グレンジム', area_type: :gym, order_index: 18 },
      { name: 'トキワジム', area_type: :gym, order_index: 19 }
    ]

    areas.each do |area_data|
      create!(area_data.merge(game_title: game_title))
    end
  end

  def self.create_johto_areas(game_title)
    # ジョウト地方のエリア定義（簡略版）
    areas = [
      { name: 'ルート29', area_type: :route, order_index: 1 },
      { name: 'ルート30', area_type: :route, order_index: 2 },
      { name: 'ルート31', area_type: :route, order_index: 3 },
      { name: 'キキョウジム', area_type: :gym, order_index: 4 },
      { name: 'ヒワダジム', area_type: :gym, order_index: 5 }
      # 他のエリアも追加可能
    ]

    areas.each do |area_data|
      create!(area_data.merge(game_title: game_title))
    end
  end
end
