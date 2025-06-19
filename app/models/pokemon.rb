class Pokemon < ApplicationRecord
  belongs_to :challenge
  belongs_to :area

  # ステータスの定義
  enum :status, {
    alive: 0,      # 生存
    dead: 1,       # 死亡
    boxed: 2       # ボックス保管
  }

  # ポケモンの性格一覧
  NATURES = [
    "がんばりや", "さみしがり", "ゆうかん", "いじっぱり", "やんちゃ",
    "ずぶとい", "すなお", "のんき", "わんぱく", "のうてんき",
    "おくびょう", "せっかち", "まじめ", "ようき", "むじゃき",
    "ひかえめ", "おっとり", "れいせい", "てれや", "うっかりや",
    "おだやか", "おとなしい", "なまいき", "しんちょう", "きまぐれ"
  ].freeze

  # ポケモンの性別一覧
  GENDERS = [ "♂", "♀", "不明" ].freeze

  # バリデーション
  validates :nickname, presence: true, length: { minimum: 1, maximum: 20 }
  validates :species, presence: true, length: { minimum: 1, maximum: 50 }
  validates :level, presence: true, numericality: {
    greater_than: 0,
    less_than_or_equal_to: 100
  }
  validates :nature, inclusion: { in: NATURES }, allow_blank: true
  validates :status, presence: true
  validates :caught_at, presence: true

  # スコープ
  scope :party_members, -> { where(in_party: true) }
  scope :not_in_party, -> { where(in_party: false) }
  scope :alive_pokemon, -> { where(status: :alive) }
  scope :dead_pokemon, -> { where(status: :dead) }
  scope :boxed_pokemon, -> { where(status: :boxed) }
  scope :by_caught_order, -> { order(:caught_at) }
  scope :by_level, -> { order(level: :desc) }

  # バリデーション - パーティメンバーは最大6匹まで
  validate :party_size_limit, if: :in_party?

  # コールバック
  before_save :handle_status_changes

  # メソッド
  def status_display
    case status
    when "alive" then "生存"
    when "dead" then "死亡"
    when "boxed" then "ボックス"
    else status
    end
  end

  def status_badge_class
    case status
    when "alive" then "bg-success"
    when "dead" then "bg-danger"
    when "boxed" then "bg-secondary"
    else "bg-primary"
    end
  end

  def status_icon
    case status
    when "alive" then "💚"
    when "dead" then "💀"
    when "boxed" then "📦"
    else "❓"
    end
  end

  def gender
    # データベースにgenderカラムがない場合は、ランダムまたはデフォルト値を返す
    GENDERS.sample || "不明"
  end

  def pokemon_type
    # データベースにpokemon_typeカラムがない場合は、デフォルト値を返す
    # 本来はspeciesからタイプを判定するロジックを実装
    "ノーマル"
  end

  def notes
    # データベースにnotesカラムがない場合は、空文字を返す
    ""
  end

  def survival_days
    return nil unless caught_at

    end_time = died_at || Time.current
    ((end_time - caught_at) / 1.day).to_i
  end

  def display_name
    "#{nickname} (#{species})"
  end

  def can_be_in_party?
    alive? && !dead?
  end

  private

  def party_size_limit
    return unless in_party? && challenge_id

    party_count = challenge.pokemons.party_members.where.not(id: id).count
    if party_count >= 6
      errors.add(:in_party, "パーティには最大6匹までしか入れられません")
    end
  end

  def handle_status_changes
    # 死亡時の処理
    if status_changed? && dead?
      self.died_at = Time.current if died_at.blank?
      self.in_party = false  # パーティから除外
    end

    # ボックス保管時の処理
    if status_changed? && boxed?
      self.in_party = false  # パーティから除外
    end
  end

  # 統計メソッド
  class << self
    # 全体統計
    def total_stats
      {
        total_pokemon: count,
        alive: alive_pokemon.count,
        dead: dead_pokemon.count,
        boxed: boxed_pokemon.count,
        survival_rate: calculate_survival_rate,
        party_members: party_members.count
      }
    end

    # 種族別統計（TOP 10）
    def species_popularity_stats(limit = 10)
      group(:species)
        .order("count_species DESC")
        .limit(limit)
        .count(:species)
    end

    # レベル分布統計
    def level_distribution_stats
      group(:level)
        .order(:level)
        .count
    end

    # 性格別統計
    def nature_stats
      where.not(nature: [ nil, "" ])
        .group(:nature)
        .count
        .sort_by { |_, count| -count }
        .to_h
    end

    # エリア別捕獲統計
    def area_catch_stats
      joins(:area)
        .group("areas.name")
        .count
        .sort_by { |_, count| -count }
        .to_h
    end

    # 月別捕獲統計
    def monthly_catch_stats(months = 12)
      pokemons = where(caught_at: months.months.ago..Time.current)
      monthly_counts = {}
      
      pokemons.each do |pokemon|
        month_key = pokemon.caught_at.beginning_of_month
        monthly_counts[month_key] = (monthly_counts[month_key] || 0) + 1
      end
      
      monthly_counts.sort.to_h
    end

    # パーティメンバー使用頻度
    def party_usage_stats
      species_usage = joins(:challenge)
        .where(in_party: true)
        .group(:species)
        .count
        .sort_by { |_, count| -count }
        .to_h

      { most_used_in_party: species_usage }
    end

    private

    def calculate_survival_rate
      total = count
      return 0 if total == 0

      alive_count = alive_pokemon.count
      ((alive_count.to_f / total) * 100).round(1)
    end
  end
end
