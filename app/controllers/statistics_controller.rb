class StatisticsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_challenge, only: [:index, :challenge_stats]

  def index
    @challenges = current_user.challenges.includes(:pokemons, :event_logs, :milestones)
    
    if @challenges.any?
      @overall_stats = calculate_overall_statistics
      @monthly_data = calculate_monthly_statistics
      @popular_pokemon = calculate_popular_pokemon
      @survival_analysis = calculate_survival_analysis
      @area_danger_map = calculate_area_danger_statistics
      @recent_activities = recent_activities_data
    end
  end

  def challenge_stats
    @challenge_stats = calculate_challenge_statistics(@challenge)
    @monthly_challenge_data = calculate_monthly_challenge_statistics(@challenge)
    @pokemon_timeline = calculate_pokemon_timeline(@challenge)
    @milestone_progress = calculate_milestone_progress(@challenge)
    
    render json: {
      challenge_stats: @challenge_stats,
      monthly_data: @monthly_challenge_data,
      pokemon_timeline: @pokemon_timeline,
      milestone_progress: @milestone_progress
    }
  end

  private

  def set_challenge
    @challenge = current_user.challenges.find(params[:challenge_id]) if params[:challenge_id]
  end

  # 全体統計の計算
  def calculate_overall_statistics
    challenges = current_user.challenges
    pokemons = Pokemon.joins(:challenge).where(challenge: challenges)
    event_logs = EventLog.joins(:challenge).where(challenge: challenges)
    
    {
      total_challenges: challenges.count,
      completed_challenges: challenges.completed.count,
      total_pokemon_caught: pokemons.count,
      total_pokemon_alive: pokemons.alive.count,
      total_pokemon_dead: pokemons.dead.count,
      overall_survival_rate: calculate_survival_rate(pokemons),
      total_events: event_logs.count,
      avg_challenge_duration: calculate_average_challenge_duration(challenges)
    }
  end

  # 月別統計の計算
  def calculate_monthly_statistics
    challenges = current_user.challenges
    event_logs = EventLog.joins(:challenge).where(challenge: challenges)
    
    # 過去12ヶ月のデータ
    12.times.map do |i|
      month = i.months.ago.beginning_of_month
      month_end = month.end_of_month
      
      month_logs = event_logs.where(occurred_at: month..month_end)
      month_pokemons = Pokemon.joins(:challenge).where(challenge: challenges, created_at: month..month_end)
      
      {
        month: month.strftime('%Y-%m'),
        month_name: month.strftime('%Y年%m月'),
        pokemon_caught: month_logs.pokemon_caught.count,
        pokemon_died: month_logs.pokemon_died.count,
        gym_battles: month_logs.gym_battle.count,
        milestones: month_logs.milestone_completed.count,
        survival_rate: calculate_survival_rate(month_pokemons)
      }
    end.reverse
  end

  # 人気ポケモンランキング
  def calculate_popular_pokemon
    challenges = current_user.challenges
    pokemons = Pokemon.joins(:challenge).where(challenge: challenges)
    
    species_stats = pokemons.group(:species)
                           .group(:primary_type)
                           .select('species, primary_type, COUNT(*) as count, 
                                   COUNT(CASE WHEN status = 0 THEN 1 END) as alive_count,
                                   COUNT(CASE WHEN status = 1 THEN 1 END) as dead_count')
                           .order('count DESC')
                           .limit(10)
    
    species_stats.map do |stat|
      survival_rate = stat.count > 0 ? (stat.alive_count.to_f / stat.count * 100).round(1) : 0
      
      {
        species: stat.species,
        primary_type: stat.primary_type,
        total_count: stat.count,
        alive_count: stat.alive_count,
        dead_count: stat.dead_count,
        survival_rate: survival_rate,
        usage_percentage: 0 # 後で計算
      }
    end
  end

  # 生存率分析
  def calculate_survival_analysis
    challenges = current_user.challenges
    pokemons = Pokemon.joins(:challenge).where(challenge: challenges)
    
    # タイプ別生存率
    type_survival = {}
    TypeEffectiveness::POKEMON_TYPES.each do |type|
      type_pokemons = pokemons.where(primary_type: type)
      next if type_pokemons.empty?
      
      type_survival[type] = {
        total: type_pokemons.count,
        alive: type_pokemons.alive.count,
        dead: type_pokemons.dead.count,
        survival_rate: calculate_survival_rate(type_pokemons)
      }
    end
    
    # レベル別生存率
    level_survival = (1..100).step(10).map do |level_start|
      level_end = level_start + 9
      level_pokemons = pokemons.where(level: level_start..level_end)
      
      next if level_pokemons.empty?
      
      {
        level_range: "Lv.#{level_start}-#{level_end}",
        total: level_pokemons.count,
        alive: level_pokemons.alive.count,
        dead: level_pokemons.dead.count,
        survival_rate: calculate_survival_rate(level_pokemons)
      }
    end.compact
    
    {
      type_survival: type_survival,
      level_survival: level_survival,
      overall_trends: calculate_survival_trends(pokemons)
    }
  end

  # エリア別危険度統計
  def calculate_area_danger_statistics
    challenges = current_user.challenges
    areas_with_stats = Area.joins(pokemons: :challenge)
                          .where(challenge: challenges)
                          .group('areas.name')
                          .select('areas.name, areas.id,
                                  COUNT(pokemons.id) as total_pokemon,
                                  COUNT(CASE WHEN pokemons.status = 1 THEN 1 END) as dead_pokemon')
                          .having('COUNT(pokemons.id) > 0')
    
    areas_with_stats.map do |area|
      death_rate = area.total_pokemon > 0 ? (area.dead_pokemon.to_f / area.total_pokemon * 100).round(1) : 0
      danger_level = case death_rate
                    when 0..10 then 'safe'
                    when 11..25 then 'low'
                    when 26..50 then 'medium'
                    when 51..75 then 'high'
                    else 'critical'
                    end
      
      {
        area_name: area.name,
        total_pokemon: area.total_pokemon,
        dead_pokemon: area.dead_pokemon,
        death_rate: death_rate,
        danger_level: danger_level,
        safety_score: (100 - death_rate).round(1)
      }
    end.sort_by { |area| -area[:death_rate] }
  end

  # 最近のアクティビティ
  def recent_activities_data
    challenges = current_user.challenges
    EventLog.joins(:challenge)
           .where(challenge: challenges)
           .includes(:pokemon, :challenge)
           .recent
           .limit(20)
           .map do |log|
      {
        id: log.id,
        title: log.title,
        description: log.description,
        event_type: log.event_type,
        event_type_display: log.event_type_display,
        event_type_icon: log.event_type_icon,
        importance: log.importance,
        importance_info: log.importance_info,
        occurred_at: log.occurred_at,
        time_ago: log.time_ago,
        pokemon_name: log.pokemon_name,
        challenge_name: log.challenge.name,
        location: log.location
      }
    end
  end

  # ヘルパーメソッド
  def calculate_survival_rate(pokemons)
    return 0 if pokemons.empty?
    
    total = pokemons.count
    alive = pokemons.alive.count
    (alive.to_f / total * 100).round(1)
  end

  def calculate_completion_rate(milestones)
    return 0 if milestones.empty?
    
    total = milestones.count
    completed = milestones.completed.count
    (completed.to_f / total * 100).round(1)
  end

  def calculate_average_challenge_duration(challenges)
    completed = challenges.completed
    return 0 if completed.empty?
    
    total_days = completed.sum do |challenge|
      if challenge.completed_at && challenge.created_at
        (challenge.completed_at - challenge.created_at) / 1.day
      else
        0
      end
    end
    
    (total_days / completed.count).round(1)
  end

  def calculate_survival_trends(pokemons)
    # 簡単な生存率トレンド計算
    total = pokemons.count
    alive = pokemons.alive.count
    return {} if total == 0
    
    {
      current_survival_rate: (alive.to_f / total * 100).round(1),
      trend: 'stable' # 後で詳細実装
    }
  end

  def calculate_challenge_statistics(challenge)
    pokemons = challenge.pokemons
    event_logs = challenge.event_logs
    milestones = challenge.milestones
    
    {
      pokemon_stats: {
        total: pokemons.count,
        alive: pokemons.alive.count,
        dead: pokemons.dead.count,
        boxed: pokemons.boxed.count,
        survival_rate: calculate_survival_rate(pokemons)
      },
      milestone_stats: {
        total: milestones.count,
        completed: milestones.completed.count,
        completion_rate: calculate_completion_rate(milestones)
      },
      event_stats: {
        total: event_logs.count,
        pokemon_caught: event_logs.pokemon_caught.count,
        pokemon_died: event_logs.pokemon_died.count,
        gym_battles: event_logs.gym_battle.count,
        important_events: event_logs.important.count
      }
    }
  end

  def calculate_monthly_challenge_statistics(challenge)
    if challenge.created_at > 12.months.ago
      start_date = challenge.created_at.beginning_of_month
    else
      start_date = 12.months.ago.beginning_of_month
    end
    
    months = []
    current_month = start_date
    
    while current_month <= Date.current.end_of_month
      month_end = current_month.end_of_month
      month_logs = challenge.event_logs.where(occurred_at: current_month..month_end)
      
      months << {
        month: current_month.strftime('%Y-%m'),
        month_name: current_month.strftime('%Y年%m月'),
        pokemon_caught: month_logs.pokemon_caught.count,
        pokemon_died: month_logs.pokemon_died.count,
        gym_battles: month_logs.gym_battle.count,
        milestones: month_logs.milestone_completed.count
      }
      
      current_month = current_month.next_month.beginning_of_month
    end
    
    months
  end

  def calculate_pokemon_timeline(challenge)
    challenge.pokemons.includes(:area)
             .order(:created_at)
             .limit(20)
             .map do |pokemon|
      survival_days = if pokemon.died_at && pokemon.created_at
                       (pokemon.died_at - pokemon.created_at) / 1.day
                     elsif pokemon.alive?
                       (Time.current - pokemon.created_at) / 1.day
                     else
                       0
                     end
      
      {
        name: pokemon.display_name,
        species: pokemon.species,
        status: pokemon.status,
        level: pokemon.level,
        area: pokemon.area.name,
        caught_at: pokemon.created_at.strftime('%Y-%m-%d'),
        survival_days: survival_days.round(1)
      }
    end
  end

  def calculate_milestone_progress(challenge)
    challenge.milestones.by_order.map do |milestone|
      {
        name: milestone.name,
        type: milestone.milestone_type,
        completed: milestone.completed?,
        completed_at: milestone.completed_at&.strftime('%Y-%m-%d'),
        progress: milestone.progress_percentage
      }
    end
  end
end
