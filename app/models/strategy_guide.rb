class StrategyGuide < ApplicationRecord
  belongs_to :target_boss, class_name: 'BossBattle', optional: true

  # ガイドタイプの定義
  enum :guide_type, {
    general: 0,           # 一般的な攻略
    team_building: 1,     # パーティ構成
    specific_pokemon: 2,  # 特定ポケモン攻略
    nuzlocke_tips: 3,     # ナズロック攻略
    early_game: 4,        # 序盤攻略
    mid_game: 5,          # 中盤攻略
    late_game: 6,         # 終盤攻略
    emergency: 7          # 緊急時対策
  }

  # バリデーション
  validates :title, presence: true, length: { minimum: 1, maximum: 200 }
  validates :guide_type, presence: true
  validates :game_title, presence: true, inclusion: { in: Challenge::GAME_TITLES.map(&:last) }
  validates :content, presence: true, length: { minimum: 10 }
  validates :difficulty, presence: true, inclusion: { in: 1..5 }
  validates :author, presence: true

  # スコープ
  scope :published, -> { where(is_public: true) }
  scope :by_game, ->(game) { where(game_title: game) }
  scope :by_type, ->(type) { where(guide_type: type) }
  scope :by_difficulty, ->(diff) { where(difficulty: diff) }
  scope :popular, -> { order(likes_count: :desc, views_count: :desc) }
  scope :recent, -> { order(created_at: :desc) }
  scope :for_boss, ->(boss_id) { where(target_boss_id: boss_id) }

  # メソッド
  def guide_type_display
    case guide_type
    when "general" then "一般攻略"
    when "team_building" then "パーティ構成"
    when "specific_pokemon" then "特定ポケモン攻略"
    when "nuzlocke_tips" then "ナズロック攻略"
    when "early_game" then "序盤攻略"
    when "mid_game" then "中盤攻略"
    when "late_game" then "終盤攻略"
    when "emergency" then "緊急時対策"
    else guide_type
    end
  end

  def guide_type_icon
    case guide_type
    when "general" then "📝"
    when "team_building" then "👥"
    when "specific_pokemon" then "🎯"
    when "nuzlocke_tips" then "⚡"
    when "early_game" then "🌱"
    when "mid_game" then "🌿"
    when "late_game" then "🌳"
    when "emergency" then "🚨"
    else "📖"
    end
  end

  def difficulty_info
    BossBattle::DIFFICULTY_LEVELS[difficulty] || BossBattle::DIFFICULTY_LEVELS[1]
  end

  def difficulty_badge_class
    "badge bg-#{difficulty_info[:color]}"
  end

  def game_title_display
    Challenge::GAME_TITLES.find { |title| title[1] == game_title }&.first || game_title
  end

  def target_boss_name
    target_boss&.name || "汎用"
  end

  def display_title
    "#{guide_type_icon} #{title}"
  end

  def tag_list
    return [] if tags.blank?
    tags.split(',').map(&:strip)
  end

  def tag_list=(new_tags)
    if new_tags.is_a?(Array)
      self.tags = new_tags.join(', ')
    else
      self.tags = new_tags
    end
  end

  def increment_views!
    increment!(:views_count)
  end

  def increment_likes!
    increment!(:likes_count)
  end

  def decrement_likes!
    decrement!(:likes_count) if likes_count > 0
  end

  def popularity_score
    (likes_count * 2) + (views_count * 0.1)
  end

  # 検索メソッド
  def self.search(query)
    return all if query.blank?
    
    where("title LIKE ? OR content LIKE ? OR tags LIKE ?", 
          "%#{query}%", "%#{query}%", "%#{query}%")
  end

  def self.by_tags(tag_list)
    return all if tag_list.blank?
    
    tag_conditions = tag_list.map { |tag| "tags LIKE ?" }
    tag_values = tag_list.map { |tag| "%#{tag}%" }
    
    where(tag_conditions.join(' OR '), *tag_values)
  end

  # デフォルトガイド作成
  def self.create_default_guides_for_game(game_title)
    return if exists?(game_title: game_title, guide_type: :general)

    case game_title
    when "red", "green", "blue", "yellow"
      create_kanto_guides(game_title)
    when "gold", "silver", "crystal"
      create_johto_guides(game_title)
    end
  end

  private

  def self.create_kanto_guides(game_title)
    guides = [
      {
        title: "ナズロック基本攻略 - カントー編",
        guide_type: :nuzlocke_tips,
        difficulty: 2,
        author: "攻略班",
        content: <<~CONTENT
          ## カントー地方ナズロック攻略の基本

          ### 重要なポイント
          1. **御三家選択**: フシギダネが最も安定
          2. **序盤の捕獲**: ポッポ、コラッタは必須級
          3. **レベル上げ**: 各ジム前に十分なレベリング
          4. **タイプ相性**: 弱点を突かれない立ち回り

          ### 危険エリア
          - チャンピオンロード: 高レベルの野生ポケモン
          - 四天王戦: 特にワタルのカイリュー
        CONTENT
      },
      {
        title: "パーティ構成の基本",
        guide_type: :team_building,
        difficulty: 2,
        author: "攻略班",
        content: <<~CONTENT
          ## 理想的なパーティ構成

          ### 必要な役割
          1. **物理アタッカー**: 高攻撃力ポケモン
          2. **特殊アタッカー**: 特攻の高いポケモン
          3. **壁役**: 高HP・高防御のポケモン
          4. **サポート**: 状態異常や補助技
          5. **スイーパー**: 高素早さのポケモン
          6. **HMスレーブ**: 秘伝技要員

          ### おすすめポケモン
          - **序盤**: ポッポ、コラッタ、ピカチュウ
          - **中盤**: ゴルバット、ラッキー、カビゴン
          - **終盤**: ギャラドス、ケンタロス、ラプラス
        CONTENT
      }
    ]

    guides.each do |guide_data|
      create!(guide_data.merge(game_title: game_title))
    end
  end

  def self.create_johto_guides(game_title)
    # ジョウト地方のガイド（簡略版）
    # 実装は後で拡張可能
  end
end
