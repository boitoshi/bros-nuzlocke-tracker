# frozen_string_literal: true

class Milestone < ApplicationRecord
  belongs_to :challenge

  # マイルストーンタイプの定義
  enum :milestone_type, {
    gym_badge: 0,         # ジムバッジ獲得
    elite_four: 1,        # 四天王
    champion: 2,          # チャンピオン
    story_event: 3,       # ストーリーイベント
    pokemon_catch: 4,     # ポケモン捕獲
    level_milestone: 5,   # レベル達成
    area_clear: 6,        # エリアクリア
    custom: 7             # カスタム
  }

  # バリデーション
  validates :name, presence: true, length: { minimum: 1, maximum: 100 }
  validates :milestone_type, presence: true
  validates :order_index, presence: true, numericality: { greater_than_or_equal_to: 0 }

  # スコープ
  scope :completed, -> { where.not(completed_at: nil) }
  scope :incomplete, -> { where(completed_at: nil) }
  scope :required, -> { where(is_required: true) }
  scope :optional, -> { where(is_required: false) }
  scope :by_order, -> { order(:order_index, :id) }
  scope :recent, -> { order(completed_at: :desc) }

  # メソッド
  def completed?
    completed_at.present?
  end

  def milestone_type_display
    case milestone_type
    when 'gym_badge' then 'ジムバッジ'
    when 'elite_four' then '四天王'
    when 'champion' then 'チャンピオン'
    when 'story_event' then 'ストーリー'
    when 'pokemon_catch' then 'ポケモン捕獲'
    when 'level_milestone' then 'レベル達成'
    when 'area_clear' then 'エリアクリア'
    when 'custom' then 'カスタム'
    else milestone_type
    end
  end

  def milestone_type_icon
    case milestone_type
    when 'gym_badge' then '🏆'
    when 'elite_four' then '👑'
    when 'champion' then '🥇'
    when 'story_event' then '📖'
    when 'pokemon_catch' then '⚾'
    when 'level_milestone' then '📈'
    when 'area_clear' then '🗺️'
    when 'custom' then '⭐'
    else '📍'
    end
  end

  def complete!(completion_data = {})
    update!(
      completed_at: Time.current,
      completion_data: completion_data
    )
  end

  def progress_percentage
    return 100 if completed?
    return 0 unless completion_data&.dig('target')

    current = completion_data['current'] || 0
    target = completion_data['target']

    ((current.to_f / target) * 100).round(1)
  end

  # ゲーム別デフォルトマイルストーン作成
  def self.create_default_milestones_for_challenge(challenge)
    return if exists?(challenge: challenge)

    case challenge.game_title
    when 'red', 'green', 'blue', 'yellow'
      create_kanto_milestones(challenge)
    when 'gold', 'silver', 'crystal'
      create_johto_milestones(challenge)
    end
  end

  def self.create_kanto_milestones(challenge)
    milestones = [
      # ジムバッジ
      { name: 'ニビジム攻略', milestone_type: :gym_badge, order_index: 1, game_area: 'ニビシティ',
        description: 'タケシを倒してグレーバッジを獲得' },
      { name: 'ハナダジム攻略', milestone_type: :gym_badge, order_index: 2, game_area: 'ハナダシティ',
        description: 'カスミを倒してブルーバッジを獲得' },
      { name: 'クチバジム攻略', milestone_type: :gym_badge, order_index: 3, game_area: 'クチバシティ',
        description: 'マチスを倒してオレンジバッジを獲得' },
      { name: 'タマムシジム攻略', milestone_type: :gym_badge, order_index: 4, game_area: 'タマムシシティ',
        description: 'エリカを倒してレインボーバッジを獲得' },
      { name: 'ヤマブキジム攻略', milestone_type: :gym_badge, order_index: 5, game_area: 'ヤマブキシティ',
        description: 'ナツメを倒してゴールドバッジを獲得' },
      { name: 'セキチクジム攻略', milestone_type: :gym_badge, order_index: 6, game_area: 'セキチクシティ',
        description: 'キョウを倒してピンクバッジを獲得' },
      { name: 'グレンジム攻略', milestone_type: :gym_badge, order_index: 7, game_area: 'グレンタウン',
        description: 'カツラを倒してクリムゾンバッジを獲得' },
      { name: 'トキワジム攻略', milestone_type: :gym_badge, order_index: 8, game_area: 'トキワシティ',
        description: 'サカキを倒してグリーンバッジを獲得' },

      # 四天王・チャンピオン
      { name: '四天王 カンナ撃破', milestone_type: :elite_four, order_index: 9, game_area: 'ポケモンリーグ',
        description: '氷の四天王カンナを撃破' },
      { name: '四天王 シバ撃破', milestone_type: :elite_four, order_index: 10, game_area: 'ポケモンリーグ',
        description: '格闘の四天王シバを撃破' },
      { name: '四天王 キクコ撃破', milestone_type: :elite_four, order_index: 11, game_area: 'ポケモンリーグ',
        description: 'ゴーストの四天王キクコを撃破' },
      { name: '四天王 ワタル撃破', milestone_type: :elite_four, order_index: 12, game_area: 'ポケモンリーグ',
        description: 'ドラゴンの四天王ワタルを撃破' },
      { name: 'チャンピオン撃破', milestone_type: :champion, order_index: 13, game_area: 'ポケモンリーグ',
        description: 'ライバルを倒してチャンピオンに！' },

      # ストーリーイベント
      { name: '御三家選択', milestone_type: :story_event, order_index: 0, game_area: 'マサラタウン', description: '最初のポケモンを選択',
        is_required: false },
      { name: 'ポケモン図鑑入手', milestone_type: :story_event, order_index: 0, game_area: 'マサラタウン',
        description: 'オーキド博士からポケモン図鑑をもらう', is_required: false }
    ]

    milestones.each do |milestone_data|
      create!(milestone_data.merge(challenge: challenge))
    end
  end

  def self.create_johto_milestones(challenge)
    # ジョウト地方のマイルストーン（簡略版）
    milestones = [
      { name: 'キキョウジム攻略', milestone_type: :gym_badge, order_index: 1, game_area: 'キキョウシティ',
        description: 'ハヤトを倒してウイングバッジを獲得' },
      { name: 'ヒワダジム攻略', milestone_type: :gym_badge, order_index: 2, game_area: 'ヒワダタウン',
        description: 'ツクシを倒してインセクトバッジを獲得' }
    ]

    milestones.each do |milestone_data|
      create!(milestone_data.merge(challenge: challenge))
    end
  end
end
