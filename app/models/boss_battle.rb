# frozen_string_literal: true

class BossBattle < ApplicationRecord
  belongs_to :area, optional: true
  has_many :strategy_guides, foreign_key: :target_boss_id, dependent: :destroy
  has_many :battle_records, dependent: :nullify

  # ボスタイプの定義
  enum :boss_type, {
    gym_leader: 0,        # ジムリーダー
    elite_four: 1,        # 四天王
    champion: 2,          # チャンピオン
    rival: 3,             # ライバル
    evil_team: 4,         # 悪の組織
    legendary: 5,         # 伝説ポケモン
    special: 6            # 特殊ボス
  }

  # 難易度の定義（1〜5）
  DIFFICULTY_LEVELS = {
    1 => { name: '簡単', color: 'success', icon: '😊' },
    2 => { name: '普通', color: 'info', icon: '🙂' },
    3 => { name: 'やや難', color: 'warning', icon: '😐' },
    4 => { name: '難しい', color: 'danger', icon: '😰' },
    5 => { name: '超難', color: 'dark', icon: '💀' }
  }.freeze

  # バリデーション
  validates :name, presence: true, length: { minimum: 1, maximum: 100 }
  validates :boss_type, presence: true
  validates :game_title, presence: true, inclusion: { in: Challenge::GAME_TITLES.map(&:last) }
  validates :difficulty, presence: true, inclusion: { in: 1..5 }
  validates :level, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 100 }

  # スコープ
  scope :by_game, ->(game) { where(game_title: game) }
  scope :by_type, ->(type) { where(boss_type: type) }
  scope :by_order, -> { order(:order_index, :id) }
  scope :by_difficulty, ->(diff) { where(difficulty: diff) }

  # メソッド
  def boss_type_display
    case boss_type
    when 'gym_leader' then 'ジムリーダー'
    when 'elite_four' then '四天王'
    when 'champion' then 'チャンピオン'
    when 'rival' then 'ライバル'
    when 'evil_team' then '悪の組織'
    when 'legendary' then '伝説ポケモン'
    when 'special' then '特殊ボス'
    else boss_type
    end
  end

  def boss_type_icon
    case boss_type
    when 'gym_leader' then '🏟️'
    when 'elite_four' then '👑'
    when 'champion' then '🏆'
    when 'rival' then '⚔️'
    when 'evil_team' then '💀'
    when 'legendary' then '✨'
    when 'special' then '🌟'
    else '👤'
    end
  end

  def difficulty_info
    DIFFICULTY_LEVELS[difficulty] || DIFFICULTY_LEVELS[1]
  end

  def difficulty_badge_class
    "badge bg-#{difficulty_info[:color]}"
  end

  def game_title_display
    Challenge::GAME_TITLES.find { |title| title[1] == game_title }&.first || game_title
  end

  def pokemon_team
    return [] unless pokemon_data.is_a?(Array)

    pokemon_data
  end

  def pokemon_count
    pokemon_team.size
  end

  def area_name
    area&.name || '不明'
  end

  def display_name
    "#{boss_type_icon} #{name}"
  end

  # ポケモンデータのバリデーション
  def validate_pokemon_data
    return if pokemon_data.blank?

    unless pokemon_data.is_a?(Array)
      errors.add(:pokemon_data, 'must be an array')
      return
    end

    pokemon_data.each_with_index do |pokemon, index|
      unless pokemon.is_a?(Hash)
        errors.add(:pokemon_data, "pokemon at index #{index} must be a hash")
        next
      end

      required_fields = %w[species level]
      required_fields.each do |field|
        errors.add(:pokemon_data, "pokemon at index #{index} missing #{field}") unless pokemon[field].present?
      end
    end
  end

  # ポケモンチーム作成ヘルパー
  def self.create_pokemon_team(pokemon_list)
    pokemon_list.map do |pokemon|
      {
        species: pokemon[:species],
        level: pokemon[:level],
        moves: pokemon[:moves] || [],
        ability: pokemon[:ability],
        nature: pokemon[:nature],
        item: pokemon[:item],
        stats: pokemon[:stats] || {}
      }
    end
  end

  # ゲーム別デフォルトボス作成
  def self.create_default_bosses_for_game(game_title)
    return if exists?(game_title: game_title)

    case game_title
    when 'red', 'green', 'blue', 'yellow'
      create_kanto_bosses(game_title)
    when 'gold', 'silver', 'crystal'
      create_johto_bosses(game_title)
    end
  end

  def self.create_kanto_bosses(game_title)
    # ジムリーダー
    gym_leaders = [
      {
        name: 'タケシ', boss_type: :gym_leader, level: 14, difficulty: 1, order_index: 1,
        description: 'ニビジムのジムリーダー。いわタイプの使い手。',
        pokemon_data: create_pokemon_team([
                                            { species: 'イシツブテ', level: 12, moves: %w[たいあたり まるくなる] },
                                            { species: 'イワーク', level: 14, moves: %w[たいあたり いやなおと しめつける] }
                                          ]),
        strategy_notes: 'みずタイプやくさタイプが有効。フシギダネやゼニガメがおすすめ。'
      },
      {
        name: 'カスミ', boss_type: :gym_leader, level: 21, difficulty: 2, order_index: 2,
        description: 'ハナダジムのジムリーダー。みずタイプの使い手。',
        pokemon_data: create_pokemon_team([
                                            { species: 'ヒトデマン', level: 18, moves: %w[たいあたり かたくなる] },
                                            { species: 'スターミー', level: 21, moves: %w[みずでっぽう でんこうせっか かたくなる] }
                                          ]),
        strategy_notes: 'でんきタイプやくさタイプが有効。ピカチュウやナゾノクサがおすすめ。'
      }
      # 他のジムリーダーも追加可能
    ]

    gym_leaders.each do |leader_data|
      area = Area.find_by(name: "#{leader_data[:name].gsub(/[カスミタケシ]/, { 'タケシ' => 'ニビ', 'カスミ' => 'ハナダ' })}ジム",
                          game_title: game_title)
      create!(leader_data.merge(game_title: game_title, area: area))
    end

    # 四天王・チャンピオン
    elite_four = [
      {
        name: 'カンナ', boss_type: :elite_four, level: 54, difficulty: 4, order_index: 1,
        description: '四天王の一人。こおりタイプの使い手。',
        pokemon_data: create_pokemon_team([
                                            { species: 'ジュゴン', level: 54 },
                                            { species: 'パルシェン', level: 53 },
                                            { species: 'ヤドラン', level: 54 },
                                            { species: 'ルージュラ', level: 56 },
                                            { species: 'ラプラス', level: 56 }
                                          ]),
        strategy_notes: 'ほのおタイプやでんきタイプ、かくとうタイプが有効。'
      }
      # 他の四天王・チャンピオンも追加可能
    ]

    elite_four.each do |member_data|
      create!(member_data.merge(game_title: game_title))
    end
  end

  def self.create_johto_bosses(game_title)
    # ジョウト地方のボス（簡略版）
    # 実装は後で拡張可能
  end
end
