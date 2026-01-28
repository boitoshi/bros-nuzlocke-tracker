# frozen_string_literal: true

class EventLog < ApplicationRecord
  belongs_to :challenge
  belongs_to :pokemon, optional: true

  # イベントタイプの定義
  enum :event_type, {
    pokemon_caught: 0,        # ポケモン捕獲
    pokemon_evolved: 1,       # 進化
    pokemon_died: 2,          # 死亡
    pokemon_boxed: 3,         # ボックス保管
    level_up: 4,              # レベルアップ
    gym_battle: 5,            # ジム戦
    trainer_battle: 6,        # トレーナー戦
    milestone_completed: 7,   # マイルストーン達成
    area_entered: 8,          # エリア到達
    item_obtained: 9,         # アイテム入手
    story_event: 10,          # ストーリーイベント
    custom: 11                # カスタムイベント
  }

  # 重要度の定義（1〜5）
  IMPORTANCE_LEVELS = {
    1 => { name: '通常', color: 'secondary', icon: 'ℹ️' },
    2 => { name: 'やや重要', color: 'info', icon: '📝' },
    3 => { name: '重要', color: 'warning', icon: '⚠️' },
    4 => { name: 'とても重要', color: 'primary', icon: '❗' },
    5 => { name: '超重要', color: 'danger', icon: '💀' }
  }.freeze

  # バリデーション
  validates :title, presence: true, length: { minimum: 1, maximum: 200 }
  validates :event_type, presence: true
  validates :occurred_at, presence: true
  validates :importance, presence: true, inclusion: { in: 1..5 }

  # スコープ
  scope :recent, -> { order(occurred_at: :desc) }
  scope :by_type, ->(type) { where(event_type: type) }
  scope :by_importance, ->(importance) { where(importance: importance) }
  scope :important, -> { where(importance: 4..5) }
  scope :today, -> { where(occurred_at: Date.current.all_day) }
  scope :this_week, -> { where(occurred_at: 1.week.ago..Time.current) }

  # メソッド
  def event_type_display
    case event_type
    when 'pokemon_caught' then 'ポケモン捕獲'
    when 'pokemon_evolved' then '進化'
    when 'pokemon_died' then '死亡'
    when 'pokemon_boxed' then 'ボックス保管'
    when 'level_up' then 'レベルアップ'
    when 'gym_battle' then 'ジム戦'
    when 'trainer_battle' then 'トレーナー戦'
    when 'milestone_completed' then 'マイルストーン達成'
    when 'area_entered' then 'エリア到達'
    when 'item_obtained' then 'アイテム入手'
    when 'story_event' then 'ストーリーイベント'
    when 'custom' then 'カスタム'
    else event_type
    end
  end

  def event_type_icon
    case event_type
    when 'pokemon_caught' then '⚾'
    when 'pokemon_evolved' then '✨'
    when 'pokemon_died' then '💀'
    when 'pokemon_boxed' then '📦'
    when 'level_up' then '📈'
    when 'gym_battle' then '🏟️'
    when 'trainer_battle' then '⚔️'
    when 'milestone_completed' then '🎯'
    when 'area_entered' then '🗺️'
    when 'item_obtained' then '🎁'
    when 'story_event' then '📖'
    when 'custom' then '📝'
    else '📍'
    end
  end

  def importance_info
    IMPORTANCE_LEVELS[importance] || IMPORTANCE_LEVELS[1]
  end

  def importance_badge_class
    "badge bg-#{importance_info[:color]}"
  end

  def pokemon_name
    pokemon&.display_name || '不明'
  end

  def time_ago
    distance_of_time_in_words(occurred_at, Time.current)
  end

  # 自動ログ作成メソッド
  def self.log_pokemon_caught(challenge, pokemon, location = nil)
    create!(
      challenge: challenge,
      pokemon: pokemon,
      event_type: :pokemon_caught,
      title: "#{pokemon.species}を捕獲！",
      description: "#{pokemon.nickname}として#{location || pokemon.area&.name || '未知のエリア'}で捕獲",
      location: location || pokemon.area&.name,
      occurred_at: pokemon.caught_at || Time.current,
      importance: 2,
      event_data: {
        species: pokemon.species,
        nickname: pokemon.nickname,
        level: pokemon.level,
        nature: pokemon.nature,
        area: pokemon.area&.name
      }
    )
  end

  def self.log_pokemon_death(challenge, pokemon, cause = nil)
    create!(
      challenge: challenge,
      pokemon: pokemon,
      event_type: :pokemon_died,
      title: "#{pokemon.nickname}が倒れた...",
      description: cause || "#{pokemon.nickname}(#{pokemon.species})が戦闘不能になりました",
      location: pokemon.area&.name,
      occurred_at: pokemon.died_at || Time.current,
      importance: 5,
      event_data: {
        species: pokemon.species,
        nickname: pokemon.nickname,
        level: pokemon.level,
        cause: cause,
        survival_days: pokemon.survival_days
      }
    )
  end

  def self.log_milestone_completed(challenge, milestone)
    create!(
      challenge: challenge,
      event_type: :milestone_completed,
      title: "#{milestone.name}達成！",
      description: milestone.description || 'マイルストーンを達成しました',
      location: milestone.game_area,
      occurred_at: milestone.completed_at || Time.current,
      importance: milestone.milestone_type == 'champion' ? 5 : 4,
      event_data: {
        milestone_type: milestone.milestone_type,
        milestone_name: milestone.name,
        game_area: milestone.game_area
      }
    )
  end

  def self.log_level_up(challenge, pokemon, old_level, new_level)
    create!(
      challenge: challenge,
      pokemon: pokemon,
      event_type: :level_up,
      title: "#{pokemon.nickname}がレベルアップ！",
      description: "Lv.#{old_level} → Lv.#{new_level}",
      occurred_at: Time.current,
      importance: (new_level % 10).zero? ? 3 : 1,
      event_data: {
        species: pokemon.species,
        nickname: pokemon.nickname,
        old_level: old_level,
        new_level: new_level
      }
    )
  end

  # 統計メソッド
  def self.daily_summary(challenge, date = Date.current)
    events = where(challenge: challenge, occurred_at: date.all_day)

    {
      total_events: events.count,
      pokemon_caught: events.pokemon_caught.count,
      pokemon_died: events.pokemon_died.count,
      milestones_completed: events.milestone_completed.count,
      important_events: events.important.count,
      recent_events: events.recent.limit(10)
    }
  end
end
