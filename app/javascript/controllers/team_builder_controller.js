import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["pokemonCard", "partySlot", "analysisResult", "effectivenessChart"]
  static values = { 
    challengeId: String,
    typeChart: Object,
    pokemonTypes: Array
  }

  connect() {
    console.log("🏆 Team Builder connected! ポケモンバトルの準備はいいかな？✨")
    this.setupDragAndDrop()
    this.setupTypeChart()
    this.addPokemonEffects()
  }

  setupDragAndDrop() {
    // ポケモンカードにドラッグ可能設定
    this.pokemonCardTargets.forEach(card => {
      card.draggable = true
      card.addEventListener('dragstart', this.handleDragStart.bind(this))
      card.addEventListener('dragend', this.handleDragEnd.bind(this))
      
      // ポケモンらしいホバーエフェクト
      card.addEventListener('mouseenter', this.handleCardHover.bind(this))
      card.addEventListener('mouseleave', this.handleCardLeave.bind(this))
    })

    // パーティスロットにドロップ可能設定
    this.partySlotTargets.forEach(slot => {
      slot.addEventListener('dragover', this.handleDragOver.bind(this))
      slot.addEventListener('drop', this.handleDrop.bind(this))
      slot.addEventListener('dragenter', this.handleDragEnter.bind(this))
      slot.addEventListener('dragleave', this.handleDragLeave.bind(this))
    })
  }

  setupTypeChart() {
    // タイプ相性チャートの初期化
    this.typeEffectiveness = this.typeChartValue || {}
    this.pokemonTypesList = this.pokemonTypesValue || []
    console.log("📊 Type effectiveness chart loaded:", this.typeEffectiveness)
  }

  addPokemonEffects() {
    // キラキラエフェクトをランダムに追加
    this.pokemonCardTargets.forEach((card, index) => {
      setTimeout(() => {
        this.addSparkleEffect(card)
      }, index * 200) // ちょっとずつ時差をつけて
    })
  }

  // ドラッグ開始時の処理
  handleDragStart(event) {
    const card = event.target.closest('.pokemon-card')
    if (!card) return

    card.classList.add('dragging')
    card.style.transform = 'rotate(5deg) scale(1.05)'
    
    // ポケモンデータを取得
    const pokemonData = {
      id: card.dataset.pokemonId,
      nickname: card.dataset.nickname,
      species: card.dataset.species,
      primaryType: card.dataset.primaryType,
      secondaryType: card.dataset.secondaryType,
      level: card.dataset.level
    }
    
    event.dataTransfer.setData('application/json', JSON.stringify(pokemonData))
    event.dataTransfer.effectAllowed = 'move'

    // キラキラエフェクト
    this.addSparkleEffect(card)
    
    console.log(`🐾 ${pokemonData.nickname} をドラッグ中...`)
  }

  // ドラッグ終了時の処理
  handleDragEnd(event) {
    const card = event.target.closest('.pokemon-card')
    if (!card) return

    card.classList.remove('dragging')
    card.style.transform = ''
    
    // パーティスロットのハイライトを削除
    this.partySlotTargets.forEach(slot => {
      slot.classList.remove('drag-over', 'drag-active')
    })
  }

  // ポケモンカードホバー時
  handleCardHover(event) {
    const card = event.target.closest('.pokemon-card')
    if (!card) return

    card.style.transform = 'translateY(-5px) scale(1.02)'
    card.style.boxShadow = '0 8px 25px rgba(0,0,0,0.15)'
    
    // タイプに応じたグロー効果
    const primaryType = card.dataset.primaryType
    if (primaryType) {
      card.style.boxShadow = `0 8px 25px ${this.getTypeGlowColor(primaryType)}`
    }

    // 弱点・耐性のクイック表示
    this.showQuickTypeInfo(card)
  }

  handleCardLeave(event) {
    const card = event.target.closest('.pokemon-card')
    if (!card) return

    card.style.transform = ''
    card.style.boxShadow = ''
    this.hideQuickTypeInfo(card)
  }

  // ドラッグオーバー時
  handleDragOver(event) {
    event.preventDefault()
    event.dataTransfer.dropEffect = 'move'
  }

  // ドラッグエンター時
  handleDragEnter(event) {
    const slot = event.target.closest('.party-slot')
    if (!slot) return

    slot.classList.add('drag-over')
    slot.style.transform = 'scale(1.05)'
    slot.style.background = 'linear-gradient(45deg, #ff6b6b, #4ecdc4, #45b7d1, #96ceb4)'
    slot.style.backgroundSize = '400% 400%'
    slot.style.animation = 'pokemonGradient 1.5s ease infinite'
  }

  // ドラッグリーブ時
  handleDragLeave(event) {
    const slot = event.target.closest('.party-slot')
    if (!slot) return

    slot.classList.remove('drag-over')
    slot.style.transform = ''
    slot.style.background = ''
    slot.style.animation = ''
  }

  // ドロップ時の処理
  handleDrop(event) {
    event.preventDefault()
    
    const slot = event.target.closest('.party-slot')
    if (!slot) return

    try {
      const pokemonData = JSON.parse(event.dataTransfer.getData('application/json'))
      console.log(`🎯 ${pokemonData.nickname} をパーティに追加！`)
      
      // アニメーション効果
      this.playSuccessAnimation(slot)
      
      // サーバーに送信
      this.addToParty(pokemonData.id)
      
    } catch (error) {
      console.error('ドロップ処理でエラーが発生:', error)
      this.showErrorMessage('ポケモンの追加に失敗しました 😢')
    }

    // ドラッグエフェクトをリセット
    this.handleDragLeave(event)
  }

  // パーティに追加
  async addToParty(pokemonId) {
    try {
      const response = await fetch(`/challenges/${this.challengeIdValue}/pokemons/${pokemonId}`, {
        method: 'PATCH',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content
        },
        body: JSON.stringify({
          pokemon: { in_party: true }
        })
      })

      if (response.ok) {
        this.showSuccessMessage('ポケモンをパーティに追加しました！ ✨')
        // ページをリロードまたはTurboで更新
        window.location.reload()
      } else {
        throw new Error('サーバーエラー')
      }
    } catch (error) {
      console.error('パーティ追加エラー:', error)
      this.showErrorMessage('パーティへの追加に失敗しました 😢')
    }
  }

  // タイプ相性の即座計算
  calculateTypeEffectiveness(attackingType, defendingTypes) {
    let effectiveness = 1.0
    
    defendingTypes.forEach(defendingType => {
      if (defendingType && this.typeEffectiveness[attackingType] && this.typeEffectiveness[attackingType][defendingType]) {
        effectiveness *= this.typeEffectiveness[attackingType][defendingType]
      }
    })
    
    return effectiveness
  }

  // クイック情報表示
  showQuickTypeInfo(card) {
    const primaryType = card.dataset.primaryType
    const secondaryType = card.dataset.secondaryType
    const defendingTypes = [primaryType, secondaryType].filter(Boolean)

    // 弱点・耐性を計算
    const weaknesses = []
    const resistances = []
    const immunities = []

    this.pokemonTypesList.forEach(attackingType => {
      const effectiveness = this.calculateTypeEffectiveness(attackingType, defendingTypes)
      
      if (effectiveness === 0) {
        immunities.push(attackingType)
      } else if (effectiveness >= 2.0) {
        weaknesses.push({ type: attackingType, multiplier: effectiveness })
      } else if (effectiveness <= 0.5) {
        resistances.push({ type: attackingType, multiplier: effectiveness })
      }
    })

    // ツールチップを表示
    this.showTypeTooltip(card, { weaknesses, resistances, immunities })
  }

  hideQuickTypeInfo(card) {
    const tooltip = card.querySelector('.type-tooltip')
    if (tooltip) {
      tooltip.remove()
    }
  }

  showTypeTooltip(card, typeInfo) {
    // 既存のツールチップを削除
    this.hideQuickTypeInfo(card)

    const tooltip = document.createElement('div')
    tooltip.className = 'type-tooltip position-absolute'
    tooltip.style.cssText = `
      background: rgba(0,0,0,0.9);
      color: white;
      padding: 8px 12px;
      border-radius: 8px;
      font-size: 0.8rem;
      z-index: 1000;
      bottom: 100%;
      left: 50%;
      transform: translateX(-50%);
      white-space: nowrap;
      box-shadow: 0 4px 12px rgba(0,0,0,0.3);
      animation: fadeInUp 0.3s ease;
    `

    let content = ''
    if (typeInfo.weaknesses.length > 0) {
      content += `<div class="text-danger">弱点: ${typeInfo.weaknesses.map(w => w.type).join(', ')}</div>`
    }
    if (typeInfo.resistances.length > 0) {
      content += `<div class="text-success">耐性: ${typeInfo.resistances.map(r => r.type).join(', ')}</div>`
    }
    if (typeInfo.immunities.length > 0) {
      content += `<div class="text-info">無効: ${typeInfo.immunities.join(', ')}</div>`
    }

    tooltip.innerHTML = content || '<div class="text-muted">標準的な相性</div>'
    card.style.position = 'relative'
    card.appendChild(tooltip)
  }

  // エフェクト系メソッド
  addSparkleEffect(element) {
    for (let i = 0; i < 3; i++) {
      setTimeout(() => {
        const sparkle = document.createElement('div')
        sparkle.className = 'sparkle'
        sparkle.style.cssText = `
          position: absolute;
          width: 4px;
          height: 4px;
          background: #FFD700;
          border-radius: 50%;
          pointer-events: none;
          animation: sparkleAnim 1s ease-out forwards;
          top: ${Math.random() * 100}%;
          left: ${Math.random() * 100}%;
        `
        
        element.style.position = 'relative'
        element.appendChild(sparkle)
        
        setTimeout(() => sparkle.remove(), 1000)
      }, i * 200)
    }
  }

  playSuccessAnimation(element) {
    element.style.animation = 'successPulse 0.6s ease'
    
    // 成功時のキラキラエフェクト
    for (let i = 0; i < 8; i++) {
      setTimeout(() => {
        this.createFloatingSparkle(element)
      }, i * 50)
    }
    
    setTimeout(() => {
      element.style.animation = ''
    }, 600)
  }

  createFloatingSparkle(container) {
    const sparkle = document.createElement('div')
    sparkle.innerHTML = '✨'
    sparkle.style.cssText = `
      position: absolute;
      font-size: 1.2rem;
      pointer-events: none;
      animation: floatUp 2s ease-out forwards;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      z-index: 1000;
    `
    
    container.style.position = 'relative'
    container.appendChild(sparkle)
    
    setTimeout(() => sparkle.remove(), 2000)
  }

  getTypeGlowColor(type) {
    const typeColors = {
      normal: 'rgba(168, 168, 120, 0.3)',
      fire: 'rgba(240, 128, 48, 0.3)',
      water: 'rgba(104, 144, 240, 0.3)',
      electric: 'rgba(248, 208, 48, 0.3)',
      grass: 'rgba(120, 200, 80, 0.3)',
      ice: 'rgba(152, 216, 216, 0.3)',
      fighting: 'rgba(192, 48, 40, 0.3)',
      poison: 'rgba(160, 64, 160, 0.3)',
      ground: 'rgba(224, 192, 104, 0.3)',
      flying: 'rgba(168, 144, 240, 0.3)',
      psychic: 'rgba(248, 88, 136, 0.3)',
      bug: 'rgba(168, 184, 32, 0.3)',
      rock: 'rgba(184, 160, 56, 0.3)',
      ghost: 'rgba(112, 88, 152, 0.3)',
      dragon: 'rgba(112, 56, 248, 0.3)',
      dark: 'rgba(112, 88, 72, 0.3)',
      steel: 'rgba(184, 184, 208, 0.3)',
      fairy: 'rgba(238, 153, 172, 0.3)'
    }
    return typeColors[type] || 'rgba(0,0,0,0.1)'
  }

  // メッセージ表示
  showSuccessMessage(message) {
    this.showMessage(message, 'success')
  }

  showErrorMessage(message) {
    this.showMessage(message, 'danger')
  }

  showMessage(message, type) {
    const alert = document.createElement('div')
    alert.className = `alert alert-${type} alert-dismissible fade show position-fixed`
    alert.style.cssText = `
      top: 20px;
      right: 20px;
      z-index: 9999;
      min-width: 300px;
      animation: slideInRight 0.5s ease;
    `
    alert.innerHTML = `
      ${message}
      <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    `
    
    document.body.appendChild(alert)
    
    // 5秒後に自動削除
    setTimeout(() => {
      if (alert.parentNode) {
        alert.remove()
      }
    }, 5000)
  }

  // リアルタイム分析更新
  updateAnalysis() {
    // 現在のパーティ構成を取得
    const partyPokemon = this.getPartyPokemon()
    
    if (partyPokemon.length === 0) return
    
    // 分析を実行
    const analysis = this.performTeamAnalysis(partyPokemon)
    
    // 結果を表示
    this.displayAnalysisResults(analysis)
  }

  getPartyPokemon() {
    // パーティスロットから現在のポケモンを取得
    return this.partySlotTargets
      .map(slot => slot.querySelector('.pokemon-card'))
      .filter(Boolean)
      .map(card => ({
        id: card.dataset.pokemonId,
        primaryType: card.dataset.primaryType,
        secondaryType: card.dataset.secondaryType,
        nickname: card.dataset.nickname,
        species: card.dataset.species
      }))
  }

  performTeamAnalysis(pokemon) {
    // チーム分析のロジック
    const weaknesses = this.calculateTeamWeaknesses(pokemon)
    const resistances = this.calculateTeamResistances(pokemon)
    const coverage = this.calculateTypeCoverage(pokemon)
    
    return {
      weaknesses,
      resistances,
      coverage,
      score: this.calculateTeamScore(weaknesses, resistances, coverage)
    }
  }

  calculateTeamWeaknesses(pokemon) {
    const weaknessCount = {}
    
    this.pokemonTypesList.forEach(attackingType => {
      let totalDamage = 0
      
      pokemon.forEach(p => {
        const defendingTypes = [p.primaryType, p.secondaryType].filter(Boolean)
        const effectiveness = this.calculateTypeEffectiveness(attackingType, defendingTypes)
        totalDamage += effectiveness
      })
      
      if (totalDamage > pokemon.length) {
        weaknessCount[attackingType] = (totalDamage / pokemon.length).toFixed(2)
      }
    })
    
    return Object.entries(weaknessCount)
      .sort(([,a], [,b]) => b - a)
      .slice(0, 5)
  }

  calculateTeamResistances(pokemon) {
    const resistanceCount = {}
    
    this.pokemonTypesList.forEach(attackingType => {
      let totalDamage = 0
      
      pokemon.forEach(p => {
        const defendingTypes = [p.primaryType, p.secondaryType].filter(Boolean)
        const effectiveness = this.calculateTypeEffectiveness(attackingType, defendingTypes)
        totalDamage += effectiveness
      })
      
      if (totalDamage < pokemon.length) {
        resistanceCount[attackingType] = (totalDamage / pokemon.length).toFixed(2)
      }
    })
    
    return Object.entries(resistanceCount)
      .sort(([,a], [,b]) => a - b)
      .slice(0, 5)
  }

  calculateTypeCoverage(pokemon) {
    const coveredTypes = new Set()
    
    pokemon.forEach(p => {
      coveredTypes.add(p.primaryType)
      if (p.secondaryType) coveredTypes.add(p.secondaryType)
    })
    
    return {
      covered: Array.from(coveredTypes),
      percentage: ((coveredTypes.size / this.pokemonTypesList.length) * 100).toFixed(1)
    }
  }

  calculateTeamScore(weaknesses, resistances, coverage) {
    const weaknessScore = Math.max(0, 100 - (weaknesses.length * 15))
    const resistanceScore = Math.min(100, resistances.length * 10)
    const coverageScore = parseFloat(coverage.percentage)
    
    return ((weaknessScore + resistanceScore + coverageScore) / 3).toFixed(1)
  }

  displayAnalysisResults(analysis) {
    if (!this.hasAnalysisResultTarget) return
    
    const resultHTML = `
      <div class="analysis-summary">
        <div class="row text-center">
          <div class="col-3">
            <div class="score-circle">${analysis.score}</div>
            <small>総合スコア</small>
          </div>
          <div class="col-3">
            <div class="coverage-bar" style="height: ${analysis.coverage.percentage}%"></div>
            <small>カバレッジ ${analysis.coverage.percentage}%</small>
          </div>
          <div class="col-6">
            <div class="weakness-types">
              ${analysis.weaknesses.map(([type, mult]) => 
                `<span class="type-badge type-${type}">${type} ×${mult}</span>`
              ).join('')}
            </div>
            <small>主な弱点</small>
          </div>
        </div>
      </div>
    `
    
    this.analysisResultTarget.innerHTML = resultHTML
  }
}