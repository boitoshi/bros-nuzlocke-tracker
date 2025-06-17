class Pokemon < ApplicationRecord
  belongs_to :challenge
  belongs_to :area

  # ステータスの定義
  enum status: {
    alive: 0,      # 生存
    dead: 1,       # 死亡
    boxed: 2       # ボックス保管
  }

  # ポケモンの性格一覧
  NATURES = [
    'がんばりや', 'さみしがり', 'ゆうかん', 'いじっぱり', 'やんちゃ',
    'ずぶとい', 'すなお', 'のんき', 'わんぱく', 'のうてんき',
    'おくびょう', 'せっかち', 'まじめ', 'ようき', 'むじゃき',
    'ひかえめ', 'おっとり', 'れいせい', 'てれや', 'うっかりや',
    'おだやか', 'おとなしい', 'なまいき', 'しんちょう', 'きまぐれ'
  ].freeze

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
    when 'alive' then '生存'
    when 'dead' then '死亡'
    when 'boxed' then 'ボックス'
    else status
    end
  end

  def status_badge_class
    case status
    when 'alive' then 'bg-success'
    when 'dead' then 'bg-danger'
    when 'boxed' then 'bg-secondary'
    else 'bg-primary'
    end
  end

  def status_icon
    case status
    when 'alive' then '💚'
    when 'dead' then '💀'
    when 'boxed' then '📦'
    else '❓'
    end
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
      errors.add(:in_party, 'パーティには最大6匹までしか入れられません')
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
end
