# frozen_string_literal: true

# 統計計算サービス 📊
# コントローラーから複雑な統計計算ロジックを分離
class StatisticsService
  def initialize(user, challenge = nil)
    @user = user
    @challenge = challenge
    @challenges = user.challenges.includes(:pokemons, :event_logs, :milestones)
  end

  # 全体統計計算 🌟
  def calculate_overall_statistics
    return {} if @challenges.empty?

    {
      total_challenges: @challenges.count,
      completed_challenges: @challenges.completed.count,
      in_progress_challenges: @challenges.in_progress.count,
      failed_challenges: @challenges.failed.count,
      total_pokemon_caught: total_pokemon_count,
      total_pokemon_deaths: total_death_count,
      overall_survival_rate: calculate_overall_survival_rate,
      average_challenge_duration: calculate_average_duration,
      most_played_game: calculate_most_played_game,
      total_playtime_days: calculate_total_playtime
    }
  end

  # 月別統計計算 📅
  def calculate_monthly_statistics(months_back = 12)
    monthly_data = {}

    months_back.times do |i|
      date = i.months.ago.beginning_of_month
      month_key = date.strftime('%Y-%m')

      monthly_data[month_key] = {
        challenges_started: challenges_started_in_month(date),
        challenges_completed: challenges_completed_in_month(date),
        pokemon_caught: pokemon_caught_in_month(date),
        pokemon_deaths: pokemon_deaths_in_month(date),
        survival_rate: monthly_survival_rate(date)
      }
    end

    monthly_data.sort.to_h
  end

  # 人気ポケモン統計 🏆
  def calculate_popular_pokemon
    pokemon_stats = @challenges.joins(:pokemons)
                               .group('pokemons.species')
                               .group('pokemons.status')
                               .count

    species_data = {}

    pokemon_stats.each do |(species, status), count|
      species_data[species] ||= { total: 0, alive: 0, dead: 0, boxed: 0 }
      species_data[species][:total] += count
      species_data[species][status.to_sym] += count
    end

    species_data.map do |species, data|
      {
        species: species,
        total_usage: data[:total],
        survival_rate: data[:total] > 0 ? ((data[:total] - data[:dead]).to_f / data[:total] * 100).round(1) : 0,
        deaths: data[:dead],
        popularity_score: calculate_popularity_score(data)
      }
    end.sort_by { |p| -p[:popularity_score] }.first(10)
  end

  # 生存率分析 💓
  def calculate_survival_analysis
    level_ranges = [
      { range: '1-10', min: 1, max: 10 },
      { range: '11-20', min: 11, max: 20 },
      { range: '21-30', min: 21, max: 30 },
      { range: '31-40', min: 31, max: 40 },
      { range: '41-50', min: 41, max: 50 },
      { range: '51+', min: 51, max: 100 }
    ]

    level_ranges.map do |level_range|
      pokemon_in_range = @challenges.joins(:pokemons)
                                    .where(pokemons: { level: level_range[:min]..level_range[:max] })

      total = pokemon_in_range.count
      alive = pokemon_in_range.where(pokemons: { status: 'alive' }).count

      {
        level_range: level_range[:range],
        total_count: total,
        survival_rate: total > 0 ? (alive.to_f / total * 100).round(1) : 0,
        death_rate: total > 0 ? ((total - alive).to_f / total * 100).round(1) : 0
      }
    end
  end

  # エリア危険度マップ 🗺️
  def calculate_area_danger_statistics
    area_stats = @challenges.joins(pokemons: :area)
                            .group('areas.name')
                            .group('pokemons.status')
                            .count

    area_data = {}

    area_stats.each do |(area_name, status), count|
      area_data[area_name] ||= { total: 0, deaths: 0 }
      area_data[area_name][:total] += count
      area_data[area_name][:deaths] += count if status == 'dead'
    end

    area_data.map do |area_name, data|
      danger_rate = data[:total] > 0 ? (data[:deaths].to_f / data[:total] * 100).round(1) : 0

      {
        area_name: area_name,
        total_encounters: data[:total],
        death_count: data[:deaths],
        danger_rate: danger_rate,
        safety_level: categorize_safety_level(danger_rate)
      }
    end.sort_by { |a| -a[:danger_rate] }
  end

  # 最近のアクティビティ 📈
  def recent_activities_data(limit = 10)
    @challenges.joins(:event_logs)
               .includes(event_logs: :pokemon)
               .order('event_logs.occurred_at DESC')
               .limit(limit)
               .map do |challenge|
      event = challenge.event_logs.first
      {
        challenge_name: challenge.name,
        event_type: event.event_type,
        pokemon_name: event.pokemon&.display_name,
        occurred_at: event.occurred_at,
        description: generate_activity_description(event)
      }
    end
  end

  # チャレンジ別統計計算 🎯
  def calculate_challenge_statistics(challenge)
    return {} unless challenge

    {
      basic_stats: challenge_basic_stats(challenge),
      pokemon_breakdown: challenge_pokemon_breakdown(challenge),
      milestone_progress: challenge_milestone_progress(challenge),
      battle_performance: challenge_battle_performance(challenge),
      timeline_events: challenge_timeline_events(challenge)
    }
  end

  private

  # 基本統計のヘルパーメソッド群
  def total_pokemon_count
    @challenges.joins(:pokemons).count
  end

  def total_death_count
    @challenges.joins(:pokemons).where(pokemons: { status: 'dead' }).count
  end

  def calculate_overall_survival_rate
    total = total_pokemon_count
    return 0 if total == 0

    deaths = total_death_count
    ((total - deaths).to_f / total * 100).round(1)
  end

  def calculate_average_duration
    completed = @challenges.completed.where.not(completed_at: nil)
    return 0 if completed.empty?

    total_days = completed.sum do |challenge|
      (challenge.completed_at - challenge.started_at) / 1.day
    end

    (total_days / completed.count).round(1)
  end

  def calculate_most_played_game
    game_counts = @challenges.group(:game_title).count
    return 'なし' if game_counts.empty?

    most_played = game_counts.max_by(&:last)
    Challenge::GAME_TITLES.find { |title| title[1] == most_played[0] }&.first || most_played[0]
  end

  def calculate_total_playtime
    @challenges.sum do |challenge|
      end_time = challenge.completed_at || Time.current
      ((end_time - challenge.started_at) / 1.day).to_i
    end
  end

  # 月別統計のヘルパーメソッド群
  def challenges_started_in_month(date)
    @challenges.where(started_at: date..date.end_of_month).count
  end

  def challenges_completed_in_month(date)
    @challenges.where(completed_at: date..date.end_of_month).count
  end

  def pokemon_caught_in_month(date)
    @challenges.joins(:pokemons)
               .where(pokemons: { caught_at: date..date.end_of_month })
               .count
  end

  def pokemon_deaths_in_month(date)
    @challenges.joins(:pokemons)
               .where(pokemons: { died_at: date..date.end_of_month })
               .count
  end

  def monthly_survival_rate(date)
    caught = pokemon_caught_in_month(date)
    return 0 if caught == 0

    deaths = pokemon_deaths_in_month(date)
    ((caught - deaths).to_f / caught * 100).round(1)
  end

  # 人気度スコア計算
  def calculate_popularity_score(data)
    # 使用回数 + 生存率ボーナス
    usage_score = data[:total] * 2
    survival_bonus = data[:total] > 0 ? ((data[:total] - data[:dead]).to_f / data[:total]) * 10 : 0
    usage_score + survival_bonus
  end

  # 安全度レベル分類
  def categorize_safety_level(danger_rate)
    case danger_rate
    when 0..10 then '安全'
    when 11..25 then '注意'
    when 26..50 then '危険'
    else '極めて危険'
    end
  end

  # アクティビティ説明生成
  def generate_activity_description(event)
    case event.event_type
    when 'pokemon_caught'
      "#{event.pokemon.display_name}を捕獲しました"
    when 'pokemon_died'
      "#{event.pokemon.display_name}が戦闘不能になりました"
    when 'gym_battle'
      "ジム戦に挑戦しました"
    else
      "イベントが発生しました"
    end
  end

  # チャレンジ別統計のヘルパーメソッド群
  def challenge_basic_stats(challenge)
    {
      total_pokemon: challenge.total_caught,
      party_size: challenge.party_pokemon.count,
      deaths: challenge.total_dead,
      survival_rate: challenge.survival_rate,
      duration_days: challenge.duration_in_days || 0
    }
  end

  def challenge_pokemon_breakdown(challenge)
    challenge.pokemons.group(:status).count
  end

  def challenge_milestone_progress(challenge)
    total_milestones = challenge.milestones.count
    completed_milestones = challenge.milestones.where(completed: true).count

    {
      total: total_milestones,
      completed: completed_milestones,
      progress_percentage: total_milestones > 0 ? (completed_milestones.to_f / total_milestones * 100).round(1) : 0
    }
  end

  def challenge_battle_performance(challenge)
    return {} unless challenge.respond_to?(:battle_records)

    {
      total_battles: challenge.total_battles,
      wins: challenge.battle_records.victories.count,
      win_rate: challenge.battle_win_rate,
      gym_progress: challenge.gym_battle_progress
    }
  end

  def challenge_timeline_events(challenge)
    challenge.event_logs.includes(:pokemon)
             .order(:occurred_at)
             .limit(20)
             .map do |event|
               {
                 date: event.occurred_at.strftime('%Y-%m-%d'),
                 type: event.event_type,
                 description: generate_activity_description(event)
               }
             end
  end
end
