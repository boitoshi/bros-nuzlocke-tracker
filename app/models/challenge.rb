class Challenge < ApplicationRecord
  belongs_to :user
  has_many :pokemons, dependent: :destroy

  # ステータスの定義
  enum status: {
    in_progress: 0,    # 進行中
    completed: 1,      # 完了
    failed: 2          # 失敗
  }

  # ゲームタイトルの定義
  GAME_TITLES = [
    ['ポケットモンスター 赤', 'red'],
    ['ポケットモンスター 緑', 'green'],
    ['ポケットモンスター 青', 'blue'],
    ['ポケットモンスター ピカチュウ', 'yellow'],
    ['ポケットモンスター 金', 'gold'],
    ['ポケットモンスター 銀', 'silver'],
    ['ポケットモンスター クリスタル', 'crystal'],
    ['ポケットモンスター ルビー', 'ruby'],
    ['ポケットモンスター サファイア', 'sapphire'],
    ['ポケットモンスター エメラルド', 'emerald']
  ].freeze

  # バリデーション
  validates :name, presence: true, length: { minimum: 1, maximum: 100 }
  validates :game_title, presence: true, inclusion: { in: GAME_TITLES.map(&:last) }
  validates :status, presence: true
  validates :started_at, presence: true

  # スコープ
  scope :recent, -> { order(created_at: :desc) }
  scope :by_status, ->(status) { where(status: status) }

  # メソッド
  def game_title_display
    GAME_TITLES.find { |title| title[1] == game_title }&.first || game_title
  end

  def duration_in_days
    return nil unless started_at
    
    end_time = completed_at || Time.current
    ((end_time - started_at) / 1.day).to_i
  end

  def status_badge_class
    case status
    when 'in_progress' then 'bg-primary'
    when 'completed' then 'bg-success'
    when 'failed' then 'bg-danger'
    else 'bg-secondary'
    end
  end

  # ポケモン管理メソッド
  def party_pokemon
    pokemons.party_members.alive_pokemon.limit(6)
  end

  def alive_pokemon
    pokemons.alive_pokemon
  end

  def dead_pokemon
    pokemons.dead_pokemon
  end

  def boxed_pokemon
    pokemons.boxed_pokemon
  end

  def total_caught
    pokemons.count
  end

  def total_dead
    dead_pokemon.count
  end

  def survival_rate
    return 0 if total_caught == 0
    ((total_caught - total_dead).to_f / total_caught * 100).round(1)
  end

  def party_slots_available
    6 - party_pokemon.count
  end

  def can_add_to_party?
    party_slots_available > 0
  end

  # チャレンジ作成時にエリアデータを自動生成
  def create_areas_for_game
    Area.create_default_areas_for_game(game_title)
  end
end
