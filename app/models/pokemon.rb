class Pokemon < ApplicationRecord
  belongs_to :challenge
  belongs_to :area
  
  # バトル関連の関連
  has_many :battle_participants, dependent: :destroy
  has_many :battle_records, through: :battle_participants
  has_many :mvp_battles, class_name: 'BattleRecord', foreign_key: 'mvp_pokemon_id'

  # ステータスの定義
  enum :status, {
    alive: 0,      # 生存
    dead: 1,       # 死亡
    boxed: 2       # ボックス保管
  }

  # 役割の定義
  enum :role, {
    physical_attacker: 0,    # 物理アタッカー
    special_attacker: 1,     # 特殊アタッカー
    physical_tank: 2,        # 物理受け
    special_tank: 3,         # 特殊受け
    support: 4,             # サポート
    utility: 5,             # ユーティリティ
    sweeper: 6,             # スイーパー
    wall: 7,                # 壁
    pivot: 8,               # 起点作り
    mixed_attacker: 9       # 混合アタッカー
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
  validates :primary_type, presence: true, inclusion: { in: TypeEffectiveness::POKEMON_TYPES }
  validates :secondary_type, inclusion: { in: TypeEffectiveness::POKEMON_TYPES }, allow_blank: true
  validates :role, presence: true
  validates :gender, inclusion: { in: GENDERS }, allow_blank: true
  
  # Individual Values (IVs) validation - 個体値は0-31
  validates :hp_iv, :attack_iv, :defense_iv, :special_attack_iv, :special_defense_iv, :speed_iv,
            numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 31 }
  
  # Effort Values (EVs) validation - 努力値は0-252、合計最大510
  validates :hp_ev, :attack_ev, :defense_ev, :special_attack_ev, :special_defense_ev, :speed_ev,
            numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 252 }
  validate :total_evs_within_limit

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
    # データベースのgenderカラムがある場合はそれを使用、なければデフォルト値
    super.presence || "不明"
  end

  def types
    [primary_type, secondary_type].compact
  end

  def dual_type?
    secondary_type.present?
  end

  def role_display
    case role
    when "physical_attacker" then "物理アタッカー"
    when "special_attacker" then "特殊アタッカー"
    when "physical_tank" then "物理受け"
    when "special_tank" then "特殊受け"
    when "support" then "サポート"
    when "utility" then "ユーティリティ"
    when "sweeper" then "スイーパー"
    when "wall" then "壁"
    when "pivot" then "起点作り"
    when "mixed_attacker" then "混合アタッカー"
    else role
    end
  end

  def type_display
    if dual_type?
      "#{primary_type.capitalize}/#{secondary_type.capitalize}"
    else
      primary_type.capitalize
    end
  end

  def weakness_analysis
    return @weakness_analysis if @weakness_analysis

    weaknesses = {}
    resistances = {}
    immunities = {}

    TypeEffectiveness::POKEMON_TYPES.each do |attacking_type|
      effectiveness = calculate_type_effectiveness(attacking_type)
      
      case effectiveness
      when 0.0
        immunities[attacking_type] = effectiveness
      when 0.25, 0.5
        resistances[attacking_type] = effectiveness
      when 2.0, 4.0
        weaknesses[attacking_type] = effectiveness
      end
    end

    @weakness_analysis = {
      weaknesses: weaknesses,
      resistances: resistances,
      immunities: immunities
    }
  end

  def calculate_type_effectiveness(attacking_type)
    primary_effectiveness = TypeEffectiveness.get_effectiveness(attacking_type, primary_type)
    
    if secondary_type.present?
      secondary_effectiveness = TypeEffectiveness.get_effectiveness(attacking_type, secondary_type)
      primary_effectiveness * secondary_effectiveness
    else
      primary_effectiveness
    end
  end

  def notes
    # データベースのnotesカラムがある場合はそれを使用、なければ空文字
    super.presence || ""
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

  # バトル統計メソッド ⚔️
  def battle_statistics
    return {} if battle_participants.empty?
    
    {
      total_battles: battle_participants.count,
      victories: battle_records.victories.count,
      defeats: battle_records.defeats.count,
      win_rate: calculate_win_rate,
      ko_count: battle_participants.ko_participants.count,
      survival_rate: calculate_battle_survival_rate,
      mvp_count: mvp_battles.count,
      total_damage_dealt: battle_participants.sum(:damage_dealt),
      total_damage_taken: battle_participants.sum(:damage_taken),
      battles_leveled_up: battle_participants.level_up.count,
      average_performance: battle_participants.average('damage_dealt - damage_taken')&.round(1) || 0
    }
  end

  def recent_battle_performance
    battle_participants.joins(:battle_record)
                      .order('battle_records.battle_date DESC')
                      .limit(5)
                      .includes(:battle_record)
  end

  def best_battle_performance
    battle_participants.order(:damage_dealt).last
  end

  def battle_experience_summary
    return "バトル経験なし" if battle_participants.empty?
    
    stats = battle_statistics
    summary = "#{stats[:total_battles]}戦"
    summary += "#{stats[:victories]}勝" if stats[:victories] > 0
    summary += "#{stats[:defeats]}敗" if stats[:defeats] > 0
    summary += " (勝率#{stats[:win_rate]}%)" if stats[:total_battles] > 0
    summary += " MVP#{stats[:mvp_count]}回" if stats[:mvp_count] > 0
    summary
  end

  private

  def calculate_win_rate
    return 0 if battle_records.empty?
    (battle_records.victories.count.to_f / battle_records.count * 100).round(1)
  end

  def calculate_battle_survival_rate
    return 100 if battle_participants.empty?
    survivors = battle_participants.survivors.count
    (survivors.to_f / battle_participants.count * 100).round(1)
  end

  # ステータス計算機能 🎯
  def ivs
    {
      hp: hp_iv,
      attack: attack_iv,
      defense: defense_iv,
      special_attack: special_attack_iv,
      special_defense: special_defense_iv,
      speed: speed_iv
    }
  end

  def evs
    {
      hp: hp_ev,
      attack: attack_ev,
      defense: defense_ev,
      special_attack: special_attack_ev,
      special_defense: special_defense_ev,
      speed: speed_ev
    }
  end

  def total_evs
    hp_ev + attack_ev + defense_ev + special_attack_ev + special_defense_ev + speed_ev
  end

  def iv_total
    hp_iv + attack_iv + defense_iv + special_attack_iv + special_defense_iv + speed_iv
  end

  def iv_percentage
    return 0 if iv_total == 0
    ((iv_total.to_f / 186) * 100).round(1)  # 186 = 31 * 6
  end

  # 性格補正を取得
  def nature_modifier(stat)
    return 1.0 unless nature.present?
    
    nature_effects = {
      "いじっぱり" => { attack: 1.1, special_attack: 0.9 },
      "ようき" => { speed: 1.1, special_attack: 0.9 },
      "ひかえめ" => { special_attack: 1.1, attack: 0.9 },
      "おくびょう" => { speed: 1.1, attack: 0.9 },
      "ずぶとい" => { defense: 1.1, attack: 0.9 },
      "おだやか" => { special_defense: 1.1, attack: 0.9 },
      "わんぱく" => { defense: 1.1, special_attack: 0.9 },
      "しんちょう" => { special_defense: 1.1, special_attack: 0.9 }
    }
    
    modifier = nature_effects[nature]
    return 1.0 unless modifier
    
    modifier[stat.to_sym] || 1.0
  end

  # 実際のステータス値を計算（簡易版）
  def calculate_stat(stat_name, base_stat = 50)
    case stat_name.to_sym
    when :hp
      # HP計算式: ((種族値 * 2 + 個体値 + 努力値 / 4) * レベル / 100) + レベル + 10
      ((base_stat * 2 + hp_iv + hp_ev / 4.0) * level / 100.0).floor + level + 10
    else
      # その他のステータス計算式: (((種族値 * 2 + 個体値 + 努力値 / 4) * レベル / 100) + 5) * 性格補正
      base_value = ((base_stat * 2 + send("#{stat_name}_iv") + send("#{stat_name}_ev") / 4.0) * level / 100.0).floor + 5
      (base_value * nature_modifier(stat_name)).floor
    end
  end

  # 実際のステータス一覧
  def calculated_stats(base_stats = {})
    default_base = 50  # デフォルトの種族値
    
    {
      hp: calculate_stat(:hp, base_stats[:hp] || default_base),
      attack: calculate_stat(:attack, base_stats[:attack] || default_base),
      defense: calculate_stat(:defense, base_stats[:defense] || default_base),
      special_attack: calculate_stat(:special_attack, base_stats[:special_attack] || default_base),
      special_defense: calculate_stat(:special_defense, base_stats[:special_defense] || default_base),
      speed: calculate_stat(:speed, base_stats[:speed] || default_base)
    }
  end

  def self.human_enum_name(enum_name, value)
    case enum_name.to_sym
    when :role
      case value.to_s
      when 'physical_attacker' then '物理アタッカー'
      when 'special_attacker' then '特殊アタッカー'
      when 'physical_tank' then '物理受け'
      when 'special_tank' then '特殊受け'
      when 'support' then 'サポート'
      when 'utility' then 'ユーティリティ'
      when 'sweeper' then 'スイーパー'
      when 'wall' then '壁'
      when 'pivot' then '起点作り'
      when 'mixed_attacker' then '混合アタッカー'
      else value.to_s
      end
    else
      value.to_s
    end
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

  # EVs合計制限バリデーション
  def total_evs_within_limit
    if total_evs > 510
      errors.add(:base, "努力値の合計は510を超えることはできません (現在: #{total_evs})")
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
