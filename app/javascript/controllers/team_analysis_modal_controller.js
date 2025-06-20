import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal", "content", "chart"]
  static values = { 
    pokemon: Array,
    analysis: Object 
  }

  connect() {
    console.log("📊 Team Analysis Modal ready! ✨")
  }

  show() {
    this.modalTarget.style.display = 'flex'
    this.modalTarget.style.opacity = '0'
    this.modalTarget.style.transform = 'scale(0.9)'
    
    // ポケモンらしいアニメーション
    requestAnimationFrame(() => {
      this.modalTarget.style.transition = 'all 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275)'
      this.modalTarget.style.opacity = '1'
      this.modalTarget.style.transform = 'scale(1)'
    })

    // 詳細分析を実行
    this.performDetailedAnalysis()
    
    // キラキラエフェクト
    this.addModalSparkles()
  }

  hide() {
    this.modalTarget.style.transition = 'all 0.2s ease-out'
    this.modalTarget.style.opacity = '0'
    this.modalTarget.style.transform = 'scale(0.9)'
    
    setTimeout(() => {
      this.modalTarget.style.display = 'none'
    }, 200)
  }

  performDetailedAnalysis() {
    const pokemon = this.pokemonValue
    if (!pokemon || pokemon.length === 0) {
      this.showEmptyState()
      return
    }

    const analysis = this.calculateDetailedAnalysis(pokemon)
    this.displayDetailedResults(analysis)
  }

  calculateDetailedAnalysis(pokemon) {
    // より詳細な分析を実行
    return {
      teamComposition: this.analyzeTeamComposition(pokemon),
      typeEffectiveness: this.analyzeTypeEffectiveness(pokemon),
      strategicAnalysis: this.analyzeStrategy(pokemon),
      recommendations: this.generateDetailedRecommendations(pokemon),
      weaknessMap: this.createWeaknessMap(pokemon),
      synergy: this.analyzeSynergy(pokemon)
    }
  }

  analyzeTeamComposition(pokemon) {
    const composition = {
      physical: 0,
      special: 0,
      tank: 0,
      support: 0,
      utility: 0
    }

    if (!Array.isArray(pokemon)) {
      console.warn('Pokemon data is not an array:', pokemon)
      return composition
    }

    pokemon.forEach(p => {
      if (!p || typeof p.role !== 'string') {
        console.warn('Invalid pokemon data:', p)
        return
      }
      
      const role = p.role.toLowerCase()
      if (role.includes('physical')) composition.physical++
      if (role.includes('special')) composition.special++
      if (role.includes('tank')) composition.tank++
      if (role === 'support') composition.support++
      if (role === 'utility') composition.utility++
    })

    return composition
  }

  analyzeTypeEffectiveness(pokemon) {
    const effectiveness = {
      superWeak: [], // 4倍弱点
      weak: [],      // 2倍弱点
      resist: [],    // 0.5倍耐性
      immune: []     // 無効
    }

    // 各タイプに対する全体的な耐性を計算
    // この実装は簡略化版
    return effectiveness
  }

  analyzeStrategy(pokemon) {
    const strategies = []
    
    // パーティ構成から戦略を推測
    const physicalCount = pokemon.filter(p => p.role.includes('physical')).length
    const specialCount = pokemon.filter(p => p.role.includes('special')).length
    
    if (physicalCount > specialCount) {
      strategies.push({
        type: 'physical_offense',
        name: '物理攻撃主体',
        description: '物理アタッカー中心の戦略。高い攻撃力で一気に攻める。',
        effectiveness: 'high'
      })
    }
    
    if (specialCount > physicalCount) {
      strategies.push({
        type: 'special_offense', 
        name: '特殊攻撃主体',
        description: '特殊アタッカー中心の戦略。多様な技で弱点を突く。',
        effectiveness: 'high'
      })
    }

    return strategies
  }

  generateDetailedRecommendations(pokemon) {
    const recommendations = []
    
    // タイプバランス分析
    const types = new Set()
    pokemon.forEach(p => {
      types.add(p.primaryType)
      if (p.secondaryType) types.add(p.secondaryType)
    })
    
    if (types.size < 6) {
      recommendations.push({
        priority: 'high',
        category: 'type_diversity',
        title: 'タイプの多様性を向上',
        description: `現在${types.size}/18タイプをカバー。より多くのタイプを追加することで戦略の幅が広がります。`,
        suggestedTypes: this.getMissingImportantTypes(Array.from(types))
      })
    }

    // 役割バランス分析
    const roles = pokemon.map(p => p.role)
    const roleBalance = this.analyzeRoleBalance(roles)
    
    if (!roleBalance.balanced) {
      recommendations.push({
        priority: 'medium',
        category: 'role_balance',
        title: '役割バランスの改善',
        description: 'パーティの役割が偏っています。バランスの取れた編成を心がけましょう。',
        missingRoles: roleBalance.missing
      })
    }

    return recommendations
  }

  createWeaknessMap(pokemon) {
    const weaknessMap = {}
    
    // 18タイプそれぞれに対する被ダメージを計算
    const types = ['normal', 'fire', 'water', 'electric', 'grass', 'ice', 
                   'fighting', 'poison', 'ground', 'flying', 'psychic', 'bug',
                   'rock', 'ghost', 'dragon', 'dark', 'steel', 'fairy']
    
    types.forEach(attackType => {
      let totalDamage = 0
      pokemon.forEach(p => {
        // タイプ相性を計算（簡略化）
        const effectiveness = this.getTypeEffectiveness(attackType, p.primaryType, p.secondaryType)
        totalDamage += effectiveness
      })
      
      const averageDamage = totalDamage / pokemon.length
      weaknessMap[attackType] = {
        average: averageDamage,
        level: this.getDamageLevel(averageDamage)
      }
    })

    return weaknessMap
  }

  analyzeSynergy(pokemon) {
    // ポケモン間のシナジー分析
    const synergies = []
    
    // 例: 物理アタッカーと壁役の組み合わせ
    const attackers = pokemon.filter(p => p.role.includes('attacker'))
    const tanks = pokemon.filter(p => p.role.includes('tank'))
    
    if (attackers.length > 0 && tanks.length > 0) {
      synergies.push({
        type: 'offense_defense',
        name: '攻守バランス',
        description: 'アタッカーと耐久ポケモンの良いバランス',
        effectiveness: 'good'
      })
    }

    return synergies
  }

  displayDetailedResults(analysis) {
    const html = `
      <div class="detailed-analysis">
        ${this.renderCompositionChart(analysis.teamComposition)}
        ${this.renderStrategies(analysis.strategicAnalysis)}
        ${this.renderRecommendations(analysis.recommendations)}
        ${this.renderWeaknessHeatmap(analysis.weaknessMap)}
        ${this.renderSynergies(analysis.synergy)}
      </div>
    `
    
    this.contentTarget.innerHTML = html
  }

  renderCompositionChart(composition) {
    return `
      <div class="composition-section mb-4">
        <h5 class="mb-3">🎯 チーム構成</h5>
        <div class="row">
          ${Object.entries(composition).map(([role, count]) => `
            <div class="col-md-2 col-4 text-center mb-2">
              <div class="composition-item">
                <div class="composition-count">${count}</div>
                <small class="composition-label">${this.getRoleLabel(role)}</small>
              </div>
            </div>
          `).join('')}
        </div>
      </div>
    `
  }

  renderStrategies(strategies) {
    if (!strategies.length) return ''
    
    return `
      <div class="strategies-section mb-4">
        <h5 class="mb-3">⚔️ 推奨戦略</h5>
        <div class="row">
          ${strategies.map(strategy => `
            <div class="col-md-6 mb-2">
              <div class="strategy-card">
                <h6 class="strategy-name">${strategy.name}</h6>
                <p class="strategy-desc">${strategy.description}</p>
                <span class="badge bg-${strategy.effectiveness === 'high' ? 'success' : 'warning'}">
                  ${strategy.effectiveness === 'high' ? '高効果' : '中効果'}
                </span>
              </div>
            </div>
          `).join('')}
        </div>
      </div>
    `
  }

  renderRecommendations(recommendations) {
    if (!recommendations.length) return ''
    
    return `
      <div class="recommendations-section mb-4">
        <h5 class="mb-3">💡 改善提案</h5>
        ${recommendations.map(rec => `
          <div class="recommendation-item mb-2">
            <div class="d-flex align-items-start">
              <span class="badge bg-${rec.priority === 'high' ? 'danger' : 'warning'} me-2">
                ${rec.priority === 'high' ? '高' : '中'}
              </span>
              <div>
                <strong>${rec.title}</strong>
                <p class="mb-0 text-muted small">${rec.description}</p>
              </div>
            </div>
          </div>
        `).join('')}
      </div>
    `
  }

  renderWeaknessHeatmap(weaknessMap) {
    return `
      <div class="weakness-heatmap mb-4">
        <h5 class="mb-3">🔥 弱点ヒートマップ</h5>
        <div class="heatmap-grid">
          ${Object.entries(weaknessMap).map(([type, data]) => `
            <div class="heatmap-cell ${data.level}" 
                 title="${type}: ${data.average.toFixed(2)}倍">
              <small>${type}</small>
            </div>
          `).join('')}
        </div>
      </div>
    `
  }

  renderSynergies(synergies) {
    if (!synergies.length) return ''
    
    return `
      <div class="synergies-section">
        <h5 class="mb-3">🤝 チームシナジー</h5>
        ${synergies.map(synergy => `
          <div class="synergy-item">
            <span class="synergy-icon">✨</span>
            <strong>${synergy.name}</strong>
            <p class="mb-0 text-muted small">${synergy.description}</p>
          </div>
        `).join('')}
      </div>
    `
  }

  addModalSparkles() {
    const modal = this.modalTarget
    
    for (let i = 0; i < 5; i++) {
      setTimeout(() => {
        const sparkle = document.createElement('div')
        sparkle.innerHTML = '✨'
        sparkle.style.cssText = `
          position: absolute;
          font-size: 1rem;
          pointer-events: none;
          animation: modalSparkle 2s ease-out forwards;
          top: ${Math.random() * 100}%;
          left: ${Math.random() * 100}%;
          z-index: 1001;
        `
        
        modal.appendChild(sparkle)
        setTimeout(() => sparkle.remove(), 2000)
      }, i * 300)
    }
  }

  showEmptyState() {
    this.contentTarget.innerHTML = `
      <div class="text-center py-5">
        <i class="fas fa-info-circle fa-3x text-muted mb-3"></i>
        <h5 class="text-muted">分析するポケモンがありません</h5>
        <p class="text-muted">パーティにポケモンを追加してから分析を実行してください。</p>
      </div>
    `
  }

  // ヘルパーメソッド
  getRoleLabel(role) {
    const labels = {
      physical: '物理',
      special: '特殊', 
      tank: '耐久',
      support: 'サポート',
      utility: 'ユーティリティ'
    }
    return labels[role] || role
  }

  getTypeEffectiveness(attacking, defending1, defending2) {
    // 簡略化されたタイプ相性計算
    // 実際のアプリケーションではTypeEffectivenessモデルを使用
    return 1.0
  }

  getDamageLevel(damage) {
    if (damage >= 2.0) return 'critical'
    if (damage >= 1.5) return 'high'  
    if (damage >= 1.0) return 'normal'
    if (damage >= 0.5) return 'low'
    return 'minimal'
  }

  getMissingImportantTypes(currentTypes) {
    const important = ['water', 'fire', 'grass', 'electric', 'psychic', 'fighting']
    return important.filter(type => !currentTypes.includes(type))
  }

  analyzeRoleBalance(roles) {
    // 簡単な役割バランス分析
    const roleCount = roles.length
    const uniqueRoles = new Set(roles).size
    
    return {
      balanced: uniqueRoles >= Math.min(roleCount, 4),
      missing: roleCount < 6 ? ['追加ポケモンが必要'] : []
    }
  }
}