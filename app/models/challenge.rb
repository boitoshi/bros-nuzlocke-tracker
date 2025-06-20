class Challenge < ApplicationRecord
  belongs_to :user
  has_many :pokemons, dependent: :destroy
  has_many :rules, dependent: :destroy
  has_many :milestones, dependent: :destroy
  has_many :event_logs, dependent: :destroy
  has_many :battle_records, dependent: :destroy

  # ステータスの定義
  enum :status, {
    in_progress: 0,    # 進行中
    completed: 1,      # 完了
    failed: 2          # 失敗
  }

  # ゲームタイトルの定義
  GAME_TITLES = [
    [ "ポケットモンスター 赤", "red" ],
    [ "ポケットモンスター 緑", "green" ],
    [ "ポケットモンスター 青", "blue" ],
    [ "ポケットモンスター ピカチュウ", "yellow" ],
    [ "ポケットモンスター 金", "gold" ],
    [ "ポケットモンスター 銀", "silver" ],
    [ "ポケットモンスター クリスタル", "crystal" ],
    [ "ポケットモンスター ルビー", "ruby" ],
    [ "ポケットモンスター サファイア", "sapphire" ],
    [ "ポケットモンスター エメラルド", "emerald" ]
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
    when "in_progress" then "bg-primary"
    when "completed" then "bg-success"
    when "failed" then "bg-danger"
    else "bg-secondary"
    end
  end

  # delegateを使ってpokemons関連メソッドを簡潔に
  delegate :count, to: :pokemons, prefix: :total, allow_nil: true
  delegate :alive_pokemon, to: :pokemons
  delegate :dead_pokemon, to: :pokemons
  delegate :boxed_pokemon, to: :pokemons

  # ポケモン管理メソッド
  def party_pokemon
    pokemons.party_members.alive_pokemon.limit(6)
  end

  def total_caught
    total_count
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

  # バトル統計メソッド 🏆
  def battle_statistics
    return {} if battle_records.empty?
    
    battle_records.battle_statistics.merge({
      recent_battles: battle_records.recent.limit(5),
      gym_battles_won: battle_records.gym_battle.victories.count,
      total_gym_battles: battle_records.gym_battle.count,
      elite_four_progress: battle_records.elite_four.victories.count,
      champion_defeated: battle_records.champion.victories.exists?,
      most_active_pokemon: most_active_battle_pokemon
    })
  end

  def recent_battle_records
    battle_records.recent.includes(:participating_pokemon, :mvp_pokemon)
  end

  def total_battles
    battle_records.count
  end

  def battle_win_rate
    return 0 if total_battles == 0
    (battle_records.victories.count.to_f / total_battles * 100).round(1)
  end

  def gym_battle_progress
    {
      completed: battle_records.gym_battle.victories.count,
      attempted: battle_records.gym_battle.count,
      remaining: [8 - battle_records.gym_battle.victories.count, 0].max
    }
  end

  private

  def most_active_battle_pokemon
    return nil if battle_records.empty?
    
    # バトル参加回数が最も多いポケモンを取得（N+1クエリ対策済み）
    result = BattleParticipant.joins(:battle_record, :pokemon)
                              .where(battle_records: { challenge: self })
                              .group('pokemons.id', 'pokemons.nickname', 'pokemons.species')
                              .order('COUNT(*) DESC')
                              .limit(1)
                              .pluck('pokemons.nickname', 'pokemons.species', 'COUNT(*)')
                              .first
    
    return nil unless result
    
    nickname, species, count = result
    { name: "#{nickname} (#{species})", battle_count: count }
  end

  # コールバック
  after_create :setup_default_rules
  after_create :setup_default_milestones

  # チャレンジ作成時にエリアデータを自動生成
  def create_areas_for_game
    Area.create_default_areas_for_game(game_title)
  end

  # ルール関連メソッド
  def enabled_rules
    rules.enabled.ordered
  end

  def disabled_rules
    rules.disabled.ordered
  end

  def rules_by_type(type)
    rules.by_type(type).ordered
  end

  def has_rule?(rule_name)
    rules.enabled.exists?(name: rule_name)
  end

  def get_rule(rule_name)
    rules.find_by(name: rule_name)
  end

  def check_rule_violations(pokemon, action = nil)
    violations = []

    enabled_rules.each do |rule|
      rule_violations = rule.violation_check(pokemon, action)
      violations.concat(rule_violations)
    end

    violations
  end

  def rule_violations_summary
    summary = {}

    pokemons.each do |pokemon|
      violations = check_rule_violations(pokemon)
      if violations.any?
        summary[pokemon.id] = violations
      end
    end

    summary
  end

  private

  def setup_default_rules
    Rule.create_default_rules_for_challenge(self)
  end

  def setup_default_milestones
    Milestone.create_default_milestones_for_challenge(self)
  end

  # 統計メソッド
  class << self
    # 全体統計
    def total_stats
      {
        total_challenges: count,
        in_progress: in_progress.count,
        completed: completed.count,
        failed: failed.count,
        success_rate: calculate_success_rate
      }
    end

    # ゲームタイトル別統計
    def game_title_stats
      group(:game_title).count.transform_keys do |key|
        GAME_TITLES.find { |title| title[1] == key }&.first || key
      end
    end

    # 月別作成数統計
    def monthly_creation_stats(months = 12)
      challenges = where(created_at: months.months.ago..Time.current)
      monthly_counts = {}
      
      challenges.each do |challenge|
        month_key = challenge.created_at.beginning_of_month
        monthly_counts[month_key] = (monthly_counts[month_key] || 0) + 1
      end
      
      monthly_counts.sort.to_h
    end

    # 平均プレイ期間
    def average_duration
      completed_challenges = completed.where.not(completed_at: nil)
      return 0 if completed_challenges.empty?

      total_days = completed_challenges.sum do |challenge|
        (challenge.completed_at - challenge.started_at) / 1.day
      end

      (total_days / completed_challenges.count).round(1)
    end

    private

    def calculate_success_rate
      total = count
      return 0 if total == 0

      success_count = completed.count
      ((success_count.to_f / total) * 100).round(1)
    end
  end
end
