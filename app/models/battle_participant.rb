# frozen_string_literal: true

class BattleParticipant < ApplicationRecord
  belongs_to :battle_record
  belongs_to :pokemon

  # バリデーション
  validates :starting_level, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 100 }
  validates :ending_level, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 100 }
  validates :starting_hp, numericality: { greater_than_or_equal_to: 0 }
  validates :ending_hp, numericality: { greater_than_or_equal_to: 0 }
  validates :turns_active, numericality: { greater_than_or_equal_to: 0 }
  validates :damage_dealt, numericality: { greater_than_or_equal_to: 0 }
  validates :damage_taken, numericality: { greater_than_or_equal_to: 0 }

  # カスタムバリデーション
  validate :ending_level_not_less_than_starting
  validate :moves_used_format, if: :moves_used?

  # スコープ
  scope :ko_participants, -> { where(was_ko: true) }
  scope :survivors, -> { where(was_ko: false) }
  scope :level_up, -> { where('ending_level > starting_level') }
  scope :heavy_damage, -> { where('damage_taken > ?', 100) }

  # コールバック
  before_save :set_default_ending_level
  after_update :update_pokemon_stats, if: :saved_change_to_ending_level?

  # 表示・計算メソッド
  def pokemon_name
    pokemon.display_name
  end

  def level_gained
    ending_level - starting_level
  end

  def leveled_up?
    level_gained.positive?
  end

  def hp_lost
    [starting_hp - ending_hp, 0].max
  end

  def hp_percentage_remaining
    return 0 if starting_hp.zero?

    ((ending_hp.to_f / starting_hp) * 100).round(1)
  end

  def damage_ratio
    return 0 if damage_taken.zero?
    return Float::INFINITY if damage_dealt.zero?

    (damage_dealt.to_f / damage_taken).round(2)
  end

  def performance_rating
    score = 0

    # ダメージ効率
    score += 3 if damage_ratio >= 2.0
    score += 2 if damage_ratio >= 1.5
    score += 1 if damage_ratio >= 1.0

    # 生存性
    score += 2 unless was_ko?
    score += 1 if hp_percentage_remaining >= 50

    # 活躍度
    score += 1 if turns_active >= 3
    score += 1 if leveled_up?

    # 最大10点
    [score, 10].min
  end

  def performance_grade
    case performance_rating
    when 8..10 then 'S'
    when 6..7 then 'A'
    when 4..5 then 'B'
    when 2..3 then 'C'
    else 'D'
    end
  end

  def moves_used_list
    return [] unless moves_used.present?

    moves_used.is_a?(Array) ? moves_used : []
  end

  def unique_moves_count
    moves_used_list.uniq.length
  end

  def battle_summary
    summary = "#{pokemon_name} (Lv.#{starting_level}"
    summary += "→#{ending_level}" if leveled_up?
    summary += ')'

    summary += if was_ko?
                 ' 💀戦闘不能'
               elsif hp_percentage_remaining < 25
                 ' 🩸重傷'
               elsif hp_percentage_remaining < 50
                 ' 🤕負傷'
               else
                 ' ✅無事'
               end

    summary
  end

  # 統計用クラスメソッド
  class << self
    def average_performance_rating
      return 0 if count.zero?

      average('CASE
        WHEN was_ko = 1 THEN 0
        ELSE (damage_dealt * 1.0 / NULLIF(damage_taken, 0))
      END').round(2) || 0
    end

    def ko_rate
      return 0 if count.zero?

      (ko_participants.count.to_f / count * 100).round(1)
    end

    def level_up_rate
      return 0 if count.zero?

      (level_up.count.to_f / count * 100).round(1)
    end

    def most_active_pokemon
      joins(:pokemon)
        .group('pokemons.nickname', 'pokemons.species')
        .order('COUNT(*) DESC')
        .limit(5)
        .pluck('pokemons.nickname', 'pokemons.species', 'COUNT(*)')
        .map { |nickname, species, count| { name: "#{nickname} (#{species})", battles: count } }
    end

    def battle_participation_stats
      {
        total_participants: count,
        ko_rate: ko_rate,
        level_up_rate: level_up_rate,
        average_damage_dealt: average(:damage_dealt)&.round || 0,
        average_damage_taken: average(:damage_taken)&.round || 0,
        average_turns_active: average(:turns_active)&.round(1) || 0
      }
    end
  end

  private

  def ending_level_not_less_than_starting
    return unless starting_level && ending_level

    return unless ending_level < starting_level

    errors.add(:ending_level, 'バトル後のレベルは開始時より低くできません')
  end

  def moves_used_format
    return unless moves_used.present?

    unless moves_used.is_a?(Array)
      errors.add(:moves_used, '技リストは配列形式である必要があります')
      return
    end

    moves_used.each do |move|
      unless move.is_a?(String)
        errors.add(:moves_used, '技名は文字列である必要があります')
        break
      end
    end
  end

  def set_default_ending_level
    self.ending_level = starting_level if ending_level.blank?
  end

  def update_pokemon_stats
    return unless leveled_up?

    # ポケモンのレベルを更新
    pokemon.update!(level: ending_level) if pokemon.level < ending_level

    # レベルアップのイベントログを作成
    return unless level_gained.positive?

    EventLog.create!(
      challenge: battle_record.challenge,
      pokemon: pokemon,
      event_type: 'level_up',
      title: "#{pokemon.display_name}がレベルアップ！",
      description: "#{battle_record.battle_summary}でLv.#{starting_level}からLv.#{ending_level}にレベルアップ",
      event_data: {
        battle_record_id: battle_record.id,
        starting_level: starting_level,
        ending_level: ending_level,
        levels_gained: level_gained
      },
      occurred_at: battle_record.battle_date,
      importance: level_gained >= 5 ? 4 : 3
    )
  end
end
