class TeamBuilderController < ApplicationController
  before_action :authenticate_user!
  before_action :set_challenge

  def index
    @party_pokemon = @challenge.pokemons.party_members.alive_pokemon.includes(:area)
    @available_pokemon = @challenge.pokemons.alive_pokemon.not_in_party.includes(:area)
    @team_analysis = analyze_current_team(@party_pokemon) if @party_pokemon.any?
  end

  def analyze
    if request.post?
      pokemon_ids = params[:pokemon_ids]&.map(&:to_i) || []
      @selected_pokemon = @challenge.pokemons.where(id: pokemon_ids)
      @team_analysis = analyze_current_team(@selected_pokemon)
      @weaknesses_chart = generate_weaknesses_chart(@team_analysis)
      @roles_chart = generate_roles_chart(@selected_pokemon)
      
      render json: {
        analysis: @team_analysis,
        weaknesses_chart: @weaknesses_chart,
        roles_chart: @roles_chart,
        html: render_to_string(partial: 'analysis_results', locals: { 
          team_analysis: @team_analysis,
          weaknesses_chart: @weaknesses_chart,
          roles_chart: @roles_chart 
        })
      }
    else
      @party_pokemon = @challenge.pokemons.party_members.alive_pokemon.includes(:area)
      @available_pokemon = @challenge.pokemons.alive_pokemon.not_in_party.includes(:area)
    end
  end

  def suggest
    @party_pokemon = @challenge.pokemons.party_members.alive_pokemon.includes(:area)
    @team_analysis = analyze_current_team(@party_pokemon) if @party_pokemon.any?
    
    if @team_analysis
      @weaknesses = @team_analysis[:overall_weaknesses]
      @missing_roles = analyze_missing_roles(@party_pokemon)
      @suggestions = generate_pokemon_suggestions(@weaknesses, @missing_roles)
    end
  end

  private

  def set_challenge
    @challenge = current_user.challenges.find(params[:challenge_id])
  end

  def analyze_current_team(pokemon_list)
    return {} if pokemon_list.empty?

    # タイプ相性分析
    type_coverage = analyze_type_coverage(pokemon_list)
    overall_weaknesses = calculate_overall_weaknesses(pokemon_list)
    overall_resistances = calculate_overall_resistances(pokemon_list)
    
    # 役割分析
    role_distribution = analyze_role_distribution(pokemon_list)
    role_balance = calculate_role_balance(role_distribution)

    # 総合評価
    team_score = calculate_team_score(type_coverage, role_balance, overall_weaknesses)

    {
      pokemon_count: pokemon_list.count,
      type_coverage: type_coverage,
      overall_weaknesses: overall_weaknesses,
      overall_resistances: overall_resistances,
      role_distribution: role_distribution,
      role_balance: role_balance,
      team_score: team_score,
      recommendations: generate_recommendations(overall_weaknesses, role_balance)
    }
  end

  def analyze_type_coverage(pokemon_list)
    covered_types = Set.new
    pokemon_list.each do |pokemon|
      covered_types.add(pokemon.primary_type)
      covered_types.add(pokemon.secondary_type) if pokemon.secondary_type.present?
    end
    
    {
      covered_types: covered_types.to_a,
      coverage_percentage: (covered_types.size.to_f / TypeEffectiveness::POKEMON_TYPES.size * 100).round(1)
    }
  end

  def calculate_overall_weaknesses(pokemon_list)
    weakness_counts = Hash.new(0)
    
    TypeEffectiveness::POKEMON_TYPES.each do |attacking_type|
      total_damage = 0
      pokemon_list.each do |pokemon|
        effectiveness = pokemon.calculate_type_effectiveness(attacking_type)
        total_damage += effectiveness
      end
      
      if total_damage > pokemon_list.size
        weakness_counts[attacking_type] = (total_damage / pokemon_list.size).round(2)
      end
    end

    weakness_counts.sort_by { |_, damage| -damage }.to_h
  end

  def calculate_overall_resistances(pokemon_list)
    resistance_counts = Hash.new(0)
    
    TypeEffectiveness::POKEMON_TYPES.each do |attacking_type|
      total_damage = 0
      pokemon_list.each do |pokemon|
        effectiveness = pokemon.calculate_type_effectiveness(attacking_type)
        total_damage += effectiveness
      end
      
      if total_damage < pokemon_list.size
        resistance_counts[attacking_type] = (total_damage / pokemon_list.size).round(2)
      end
    end

    resistance_counts.sort_by { |_, damage| damage }.to_h
  end

  def analyze_role_distribution(pokemon_list)
    role_counts = Hash.new(0)
    pokemon_list.each do |pokemon|
      role_counts[pokemon.role] += 1
    end
    role_counts
  end

  def calculate_role_balance(role_distribution)
    total_pokemon = role_distribution.values.sum
    return { balanced: false, score: 0 } if total_pokemon == 0

    # 理想的な役割バランス（攻撃:防御:サポート = 3:2:1）
    ideal_ratios = {
      physical_attacker: 0.25, special_attacker: 0.25,
      physical_tank: 0.15, special_tank: 0.15,
      support: 0.10, utility: 0.10
    }

    balance_score = 0
    role_distribution.each do |role, count|
      actual_ratio = count.to_f / total_pokemon
      ideal_ratio = ideal_ratios[role.to_sym] || 0.05
      balance_score += (1 - (actual_ratio - ideal_ratio).abs) * 100
    end

    {
      balanced: balance_score > 60,
      score: (balance_score / role_distribution.size).round(1)
    }
  end

  def calculate_team_score(type_coverage, role_balance, weaknesses)
    coverage_score = type_coverage[:coverage_percentage]
    balance_score = role_balance[:score]
    weakness_penalty = weaknesses.values.sum * 10

    total_score = (coverage_score * 0.4 + balance_score * 0.4 - weakness_penalty * 0.2)
    [total_score, 0].max.round(1)
  end

  def generate_recommendations(weaknesses, role_balance)
    recommendations = []

    # 弱点に関する推奨事項
    if weaknesses.any?
      top_weakness = weaknesses.first
      recommendations << "#{top_weakness[0].capitalize}タイプに弱いです。#{top_weakness[0]}に強いタイプのポケモンを追加することをお勧めします。"
    end

    # 役割バランスに関する推奨事項
    unless role_balance[:balanced]
      recommendations << "チームの役割バランスが偏っています。異なる役割のポケモンを追加してバランスを改善しましょう。"
    end

    recommendations
  end

  def analyze_missing_roles(pokemon_list)
    existing_roles = Set.new(pokemon_list.map(&:role))
    all_roles = Set.new(Pokemon.roles.keys.map(&:to_sym))
    missing_roles = all_roles - existing_roles
    missing_roles.to_a
  end

  def generate_pokemon_suggestions(weaknesses, missing_roles)
    suggestions = []
    available_pokemon = @challenge.pokemons.alive_pokemon.not_in_party

    # 弱点をカバーできるポケモンを提案
    weaknesses.each do |weak_type, _|
      resistant_pokemon = available_pokemon.select do |pokemon|
        pokemon.calculate_type_effectiveness(weak_type) < 1.0
      end.first(3)
      
      if resistant_pokemon.any?
        suggestions << {
          reason: "#{weak_type.capitalize}タイプの攻撃に耐性があります",
          pokemon: resistant_pokemon
        }
      end
    end

    # 不足している役割を補完できるポケモンを提案
    missing_roles.each do |role|
      role_pokemon = available_pokemon.select { |p| p.role == role.to_s }.first(2)
      if role_pokemon.any?
        suggestions << {
          reason: "#{Pokemon.human_enum_name(:role, role)}として活躍できます",
          pokemon: role_pokemon
        }
      end
    end

    suggestions.uniq { |s| s[:pokemon].map(&:id) }.first(5)
  end

  def generate_weaknesses_chart(team_analysis)
    return {} unless team_analysis[:overall_weaknesses]

    {
      labels: team_analysis[:overall_weaknesses].keys.map(&:capitalize),
      data: team_analysis[:overall_weaknesses].values,
      backgroundColor: 'rgba(255, 99, 132, 0.6)',
      borderColor: 'rgba(255, 99, 132, 1)'
    }
  end

  def generate_roles_chart(pokemon_list)
    role_counts = pokemon_list.group(:role).count
    
    {
      labels: role_counts.keys.map { |role| Pokemon.human_enum_name(:role, role) },
      data: role_counts.values,
      backgroundColor: [
        '#FF6384', '#36A2EB', '#FFCE56', '#4BC0C0',
        '#9966FF', '#FF9F40', '#FF6384', '#C9CBCF'
      ]
    }
  end
end
