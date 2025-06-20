class BattleRecord < ApplicationRecord
  belongs_to :challenge
  belongs_to :boss_battle, optional: true
  belongs_to :mvp_pokemon, class_name: 'Pokemon', optional: true
  
  has_many :battle_participants, dependent: :destroy
  has_many :participating_pokemon, through: :battle_participants, source: :pokemon

  # バトルタイプの定義
  enum :battle_type, {
    gym_battle: 0,      # ジム戦
    elite_four: 1,      # 四天王戦  
    champion: 2,        # チャンピオン戦
    rival: 3,           # ライバル戦
    trainer: 4,         # 一般トレーナー戦
    wild: 5,            # 野生ポケモン戦
    legendary: 6,       # 伝説ポケモン戦
    custom: 7           # カスタム戦
  }

  # バトル結果の定義
  enum :result, {
    win: 0,             # 勝利
    loss: 1,            # 敗北
    draw: 2,            # 引き分け
    forfeit: 3          # 降参
  }

  # バリデーション
  validates :opponent_name, presence: true, length: { minimum: 1, maximum: 100 }
  validates :battle_date, presence: true
  validates :battle_type, presence: true
  validates :result, presence: true
  validates :difficulty_rating, inclusion: { in: 1..5 }
  validates :total_turns, numericality: { greater_than_or_equal_to: 0 }
  validates :experience_gained, numericality: { greater_than_or_equal_to: 0 }

  # スコープ
  scope :recent, -> { order(battle_date: :desc) }
  scope :victories, -> { where(result: :win) }
  scope :defeats, -> { where(result: :loss) }
  scope :by_battle_type, ->(type) { where(battle_type: type) }
  scope :high_difficulty, -> { where(difficulty_rating: 4..5) }

  # コールバック
  after_create :create_battle_event_log
  after_update :update_related_milestone, if: :saved_change_to_result?

  # 表示用メソッド
  def battle_type_display
    case battle_type
    when 'gym_battle' then 'ジム戦'
    when 'elite_four' then '四天王戦'
    when 'champion' then 'チャンピオン戦'
    when 'rival' then 'ライバル戦'
    when 'trainer' then 'トレーナー戦'
    when 'wild' then '野生ポケモン戦'
    when 'legendary' then '伝説ポケモン戦'
    when 'custom' then 'カスタム戦'
    else battle_type
    end
  end

  def result_display
    case result
    when 'win' then '勝利'
    when 'loss' then '敗北'
    when 'draw' then '引き分け'
    when 'forfeit' then '降参'
    else result
    end
  end

  def result_icon
    case result
    when 'win' then '🏆'
    when 'loss' then '💀'
    when 'draw' then '🤝'
    when 'forfeit' then '🏃'
    else '❓'
    end
  end

  def result_badge_class
    case result
    when 'win' then 'bg-success'
    when 'loss' then 'bg-danger'
    when 'draw' then 'bg-warning'
    when 'forfeit' then 'bg-secondary'
    else 'bg-primary'
    end
  end

  def difficulty_stars
    '⭐' * difficulty_rating
  end

  def casualty_count
    casualties&.length || 0
  end

  def participant_count
    battle_participants.count
  end

  def battle_summary
    "#{opponent_name}との#{battle_type_display}（#{result_display}）"
  end

  # 統計メソッド
  def average_level
    return 0 if battle_participants.empty?
    battle_participants.average(:starting_level).round(1)
  end

  def level_ups_count
    battle_participants.select { |p| p.ending_level > p.starting_level }.count
  end

  def total_damage_dealt
    battle_participants.sum(:damage_dealt)
  end

  def total_damage_taken
    battle_participants.sum(:damage_taken)
  end

  def ko_count
    battle_participants.where(was_ko: true).count
  end

  # EventLog連携
  def create_battle_event_log
    EventLog.create!(
      challenge: challenge,
      event_type: battle_type_to_event_type,
      title: battle_summary,
      description: battle_description_for_log,
      event_data: battle_data_for_log,
      occurred_at: battle_date,
      importance: calculate_log_importance
    )
  end

  # Milestone連携
  def update_related_milestone
    return unless win? && boss_battle.present?
    
    milestone_type = battle_type_to_milestone_type
    return unless milestone_type
    
    milestone = challenge.milestones.find_or_create_by(
      milestone_type: milestone_type,
      name: milestone_name_for_battle
    )
    
    milestone.update!(
      completed_at: battle_date,
      description: "#{opponent_name}に勝利"
    ) unless milestone.completed_at
  end

  # 統計用クラスメソッド
  class << self
    def win_rate
      return 0 if count == 0
      (victories.count.to_f / count * 100).round(1)
    end

    def average_difficulty
      return 0 if count == 0
      average(:difficulty_rating).round(1)
    end

    def most_common_battle_type
      group(:battle_type).order('count_all desc').limit(1).count.keys.first
    end

    def battle_statistics
      {
        total_battles: count,
        win_rate: win_rate,
        average_difficulty: average_difficulty,
        total_experience: sum(:experience_gained),
        average_turns: average(:total_turns)&.round(1) || 0,
        casualty_rate: calculate_casualty_rate
      }
    end

    private

    def calculate_casualty_rate
      return 0 if count == 0
      battles_with_casualties = where.not(casualties: [nil, []]).count
      (battles_with_casualties.to_f / count * 100).round(1)
    end
  end

  private

  def battle_type_to_event_type
    case battle_type
    when 'gym_battle' then 'gym_battle'
    when 'elite_four', 'champion' then 'elite_four'
    else 'trainer_battle'
    end
  end

  def battle_type_to_milestone_type
    case battle_type
    when 'gym_battle' then 'gym_badge'
    when 'elite_four' then 'elite_four'
    when 'champion' then 'champion'
    else nil
    end
  end

  def milestone_name_for_battle
    if boss_battle.present?
      boss_battle.name
    else
      "#{location} - #{opponent_name}"
    end
  end

  def battle_description_for_log
    desc = "#{opponent_name}との#{battle_type_display}"
    desc += " (#{location})" if location.present?
    desc += "\n結果: #{result_display}"
    desc += "\n参加ポケモン: #{participant_count}匹"
    desc += "\n戦闘不能: #{ko_count}匹" if ko_count > 0
    desc
  end

  def battle_data_for_log
    {
      battle_id: id,
      battle_type: battle_type,
      result: result,
      opponent: opponent_name,
      location: location,
      participants: participant_count,
      casualties: casualty_count,
      experience_gained: experience_gained,
      difficulty: difficulty_rating
    }
  end

  def calculate_log_importance
    importance = 3 # デフォルト

    # バトルタイプによる重要度調整
    case battle_type
    when 'champion' then importance = 5
    when 'elite_four', 'gym_battle' then importance = 4
    when 'legendary' then importance = 4
    when 'rival' then importance = 3
    else importance = 2
    end

    # 結果による調整
    importance -= 1 if loss?
    importance += 1 if win? && difficulty_rating >= 4

    # 範囲制限
    [importance, 1].max.tap { |i| [i, 5].min }
  end
end