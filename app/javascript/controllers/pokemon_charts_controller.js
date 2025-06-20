import { Controller } from "@hotwired/stimulus"
import { Chart, registerables } from "chart.js"

// Chart.jsの全機能を登録
Chart.register(...registerables)

export default class extends Controller {
  static targets = ["typeRadar", "roleDonut", "coverageBar", "weaknessHeatmap"]
  static values = { 
    teamData: Object,
    typeChart: Object,
    pokemonTypes: Array
  }

  connect() {
    console.log("📊 Pokemon Charts ready! ポケモンらしいグラフを描くよ〜✨")
    this.charts = {}
    this.pokemonColors = this.getPokemonColorPalette()
    this.initializeCharts()
  }

  disconnect() {
    // チャートのクリーンアップ
    Object.values(this.charts).forEach(chart => {
      if (chart) chart.destroy()
    })
  }

  initializeCharts() {
    if (this.teamDataValue && Object.keys(this.teamDataValue).length > 0) {
      this.createTypeRadarChart()
      this.createRoleDonutChart()
      this.createCoverageBarChart()
      this.createWeaknessHeatmap()
    }
  }

  // タイプ相性レーダーチャート 🕸️
  createTypeRadarChart() {
    if (!this.hasTypeRadarTarget) return

    const ctx = this.typeRadarTarget.getContext('2d')
    const data = this.prepareRadarData()

    this.charts.typeRadar = new Chart(ctx, {
      type: 'radar',
      data: {
        labels: data.labels,
        datasets: [{
          label: '耐性指数',
          data: data.resistance,
          backgroundColor: 'rgba(32, 201, 151, 0.2)',
          borderColor: 'rgba(32, 201, 151, 1)',
          borderWidth: 3,
          pointBackgroundColor: 'rgba(32, 201, 151, 1)',
          pointBorderColor: '#fff',
          pointBorderWidth: 2,
          pointRadius: 6,
          pointHoverRadius: 8,
          fill: true
        }, {
          label: '弱点指数',
          data: data.weakness,
          backgroundColor: 'rgba(255, 99, 132, 0.2)',
          borderColor: 'rgba(255, 99, 132, 1)',
          borderWidth: 3,
          pointBackgroundColor: 'rgba(255, 99, 132, 1)',
          pointBorderColor: '#fff',
          pointBorderWidth: 2,
          pointRadius: 6,
          pointHoverRadius: 8,
          fill: true
        }]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        animation: {
          duration: 2000,
          easing: 'easeInOutQuart'
        },
        scales: {
          r: {
            beginAtZero: true,
            max: 3,
            ticks: {
              stepSize: 0.5,
              font: {
                size: 12
              },
              color: '#6c757d'
            },
            grid: {
              color: 'rgba(0, 0, 0, 0.1)'
            },
            angleLines: {
              color: 'rgba(0, 0, 0, 0.1)'
            },
            pointLabels: {
              font: {
                size: 13,
                weight: 'bold'
              },
              color: '#495057'
            }
          }
        },
        plugins: {
          legend: {
            position: 'bottom',
            labels: {
              padding: 20,
              font: {
                size: 14,
                weight: '600'
              },
              usePointStyle: true,
              pointStyle: 'circle'
            }
          },
          tooltip: {
            backgroundColor: 'rgba(0, 0, 0, 0.8)',
            titleColor: '#fff',
            bodyColor: '#fff',
            borderColor: 'rgba(255, 255, 255, 0.2)',
            borderWidth: 1,
            cornerRadius: 8,
            callbacks: {
              label: (context) => {
                const value = context.parsed.r.toFixed(1)
                const label = context.dataset.label
                const interpretation = this.interpretRadarValue(value, label)
                return `${label}: ${value} (${interpretation})`
              }
            }
          }
        },
        interaction: {
          intersect: false
        }
      }
    })
  }

  // 役割分布ドーナツチャート 🍩
  createRoleDonutChart() {
    if (!this.hasRoleDonutTarget) return

    const ctx = this.roleDonutTarget.getContext('2d')
    const data = this.prepareRoleData()

    this.charts.roleDonut = new Chart(ctx, {
      type: 'doughnut',
      data: {
        labels: data.labels,
        datasets: [{
          data: data.values,
          backgroundColor: [
            'rgba(255, 99, 132, 0.8)',   // 物理アタッカー
            'rgba(54, 162, 235, 0.8)',   // 特殊アタッカー
            'rgba(255, 205, 86, 0.8)',   // 物理受け
            'rgba(75, 192, 192, 0.8)',   // 特殊受け
            'rgba(153, 102, 255, 0.8)',  // サポート
            'rgba(255, 159, 64, 0.8)',   // ユーティリティ
            'rgba(199, 199, 199, 0.8)',  // スイーパー
            'rgba(83, 102, 255, 0.8)',   // 壁
            'rgba(255, 99, 255, 0.8)',   // 起点作り
            'rgba(99, 255, 132, 0.8)'    // 混合アタッカー
          ],
          borderColor: '#fff',
          borderWidth: 3,
          hoverBorderWidth: 5,
          hoverBorderColor: '#fff'
        }]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        animation: {
          animateRotate: true,
          animateScale: true,
          duration: 2000,
          easing: 'easeInOutElastic'
        },
        plugins: {
          legend: {
            position: 'right',
            labels: {
              padding: 15,
              font: {
                size: 13,
                weight: '600'
              },
              usePointStyle: true,
              pointStyle: 'circle',
              generateLabels: function(chart) {
                const original = Chart.defaults.plugins.legend.labels.generateLabels
                const labels = original.call(this, chart)
                
                labels.forEach((label, index) => {
                  const value = chart.data.datasets[0].data[index]
                  label.text += ` (${value}匹)`
                })
                
                return labels
              }
            }
          },
          tooltip: {
            backgroundColor: 'rgba(0, 0, 0, 0.8)',
            titleColor: '#fff',
            bodyColor: '#fff',
            borderColor: 'rgba(255, 255, 255, 0.2)',
            borderWidth: 1,
            cornerRadius: 8,
            callbacks: {
              label: (context) => {
                const label = context.label
                const value = context.parsed
                const total = context.dataset.data.reduce((a, b) => a + b, 0)
                const percentage = ((value / total) * 100).toFixed(1)
                return `${label}: ${value}匹 (${percentage}%)`
              }
            }
          }
        },
        onHover: (event, elements) => {
          if (elements.length > 0) {
            this.addSparkleToChart(this.roleDonutTarget)
          }
        }
      }
    })
  }

  // タイプカバレッジ棒グラフ 📊
  createCoverageBarChart() {
    if (!this.hasCoverageBarTarget) return

    const ctx = this.coverageBarTarget.getContext('2d')
    const data = this.prepareCoverageData()

    this.charts.coverageBar = new Chart(ctx, {
      type: 'bar',
      data: {
        labels: data.labels,
        datasets: [{
          label: 'カバー済み',
          data: data.covered,
          backgroundColor: 'rgba(40, 167, 69, 0.8)',
          borderColor: 'rgba(40, 167, 69, 1)',
          borderWidth: 2,
          borderRadius: 8,
          borderSkipped: false
        }, {
          label: '未カバー',
          data: data.uncovered,
          backgroundColor: 'rgba(220, 53, 69, 0.8)',
          borderColor: 'rgba(220, 53, 69, 1)',
          borderWidth: 2,
          borderRadius: 8,
          borderSkipped: false
        }]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        animation: {
          duration: 2000,
          easing: 'easeInOutBounce'
        },
        scales: {
          x: {
            stacked: true,
            grid: {
              display: false
            },
            ticks: {
              font: {
                size: 12,
                weight: '600'
              },
              color: '#495057'
            }
          },
          y: {
            stacked: true,
            beginAtZero: true,
            max: 1,
            ticks: {
              stepSize: 0.2,
              callback: function(value) {
                return (value * 100) + '%'
              },
              font: {
                size: 12
              },
              color: '#6c757d'
            },
            grid: {
              color: 'rgba(0, 0, 0, 0.1)'
            }
          }
        },
        plugins: {
          legend: {
            position: 'top',
            labels: {
              padding: 20,
              font: {
                size: 14,
                weight: '600'
              },
              usePointStyle: true,
              pointStyle: 'circle'
            }
          },
          tooltip: {
            backgroundColor: 'rgba(0, 0, 0, 0.8)',
            titleColor: '#fff',
            bodyColor: '#fff',
            borderColor: 'rgba(255, 255, 255, 0.2)',
            borderWidth: 1,
            cornerRadius: 8,
            callbacks: {
              label: (context) => {
                const percentage = (context.parsed.y * 100).toFixed(1)
                return `${context.dataset.label}: ${percentage}%`
              }
            }
          }
        }
      }
    })
  }

  // 弱点ヒートマップ（Canvas版） 🔥
  createWeaknessHeatmap() {
    if (!this.hasWeaknessHeatmapTarget) return

    const data = this.prepareHeatmapData()
    this.drawHeatmapCanvas(data)
  }

  drawHeatmapCanvas(data) {
    const canvas = this.weaknessHeatmapTarget
    const ctx = canvas.getContext('2d')
    
    // キャンバスサイズを設定
    const cellSize = 40
    const cols = 6
    const rows = Math.ceil(data.length / cols)
    
    canvas.width = cols * cellSize
    canvas.height = rows * cellSize
    canvas.style.width = '100%'
    canvas.style.height = 'auto'
    
    // 各セルを描画
    data.forEach((item, index) => {
      const x = (index % cols) * cellSize
      const y = Math.floor(index / cols) * cellSize
      
      // 色を決定
      const color = this.getHeatmapColor(item.value)
      
      // セルを描画
      ctx.fillStyle = color
      ctx.fillRect(x, y, cellSize - 2, cellSize - 2)
      
      // 境界線
      ctx.strokeStyle = '#fff'
      ctx.lineWidth = 2
      ctx.strokeRect(x, y, cellSize - 2, cellSize - 2)
      
      // テキスト
      ctx.fillStyle = '#fff'
      ctx.font = 'bold 10px Arial'
      ctx.textAlign = 'center'
      ctx.textBaseline = 'middle'
      
      // タイプ名
      ctx.fillText(
        item.type.substring(0, 4).toUpperCase(),
        x + cellSize / 2,
        y + cellSize / 2 - 6
      )
      
      // 倍率
      ctx.font = 'bold 8px Arial'
      ctx.fillText(
        `×${item.value.toFixed(1)}`,
        x + cellSize / 2,
        y + cellSize / 2 + 6
      )
    })
    
    // アニメーション効果
    this.animateHeatmap(canvas)
  }

  // データ準備メソッド
  prepareRadarData() {
    const types = this.pokemonTypesValue
    const pokemon = this.teamDataValue.pokemon || []
    
    const resistance = []
    const weakness = []
    
    types.forEach(type => {
      let totalDamage = 0
      pokemon.forEach(p => {
        const effectiveness = this.calculateTypeEffectiveness(type, p.primaryType, p.secondaryType)
        totalDamage += effectiveness
      })
      
      const avgDamage = pokemon.length > 0 ? totalDamage / pokemon.length : 1
      
      if (avgDamage < 1) {
        resistance.push(1 / avgDamage) // 耐性として表示
        weakness.push(0)
      } else {
        resistance.push(0)
        weakness.push(avgDamage) // 弱点として表示
      }
    })
    
    return {
      labels: types.map(t => t.charAt(0).toUpperCase() + t.slice(1)),
      resistance,
      weakness
    }
  }

  prepareRoleData() {
    const pokemon = this.teamDataValue.pokemon || []
    const roleCounts = {}
    
    // 役割をカウント
    pokemon.forEach(p => {
      const role = p.role || 'unknown'
      roleCounts[role] = (roleCounts[role] || 0) + 1
    })
    
    const roleLabels = {
      'physical_attacker': '物理アタッカー',
      'special_attacker': '特殊アタッカー',
      'physical_tank': '物理受け',
      'special_tank': '特殊受け',
      'support': 'サポート',
      'utility': 'ユーティリティ',
      'sweeper': 'スイーパー',
      'wall': '壁',
      'pivot': '起点作り',
      'mixed_attacker': '混合アタッカー'
    }
    
    const labels = Object.keys(roleCounts).map(role => roleLabels[role] || role)
    const values = Object.values(roleCounts)
    
    return { labels, values }
  }

  prepareCoverageData() {
    const allTypes = this.pokemonTypesValue
    const pokemon = this.teamDataValue.pokemon || []
    
    const coveredTypes = new Set()
    pokemon.forEach(p => {
      if (p.primaryType) coveredTypes.add(p.primaryType)
      if (p.secondaryType) coveredTypes.add(p.secondaryType)
    })
    
    const labels = allTypes.map(t => t.charAt(0).toUpperCase() + t.slice(1))
    const covered = allTypes.map(type => coveredTypes.has(type) ? 1 : 0)
    const uncovered = allTypes.map(type => coveredTypes.has(type) ? 0 : 1)
    
    return { labels, covered, uncovered }
  }

  prepareHeatmapData() {
    const types = this.pokemonTypesValue
    const pokemon = this.teamDataValue.pokemon || []
    
    return types.map(type => {
      let totalDamage = 0
      pokemon.forEach(p => {
        const effectiveness = this.calculateTypeEffectiveness(type, p.primaryType, p.secondaryType)
        totalDamage += effectiveness
      })
      
      const avgDamage = pokemon.length > 0 ? totalDamage / pokemon.length : 1
      
      return {
        type,
        value: avgDamage
      }
    })
  }

  // ユーティリティメソッド
  calculateTypeEffectiveness(attacking, defending1, defending2) {
    const typeChart = this.typeChartValue
    let effectiveness = 1.0
    
    // 第1タイプとの相性
    if (typeChart[attacking] && typeChart[attacking][defending1]) {
      effectiveness *= typeChart[attacking][defending1]
    }
    
    // 第2タイプとの相性（存在する場合）
    if (defending2 && typeChart[attacking] && typeChart[attacking][defending2]) {
      effectiveness *= typeChart[attacking][defending2]
    }
    
    return effectiveness
  }

  getHeatmapColor(value) {
    if (value >= 2.0) return '#dc3545' // 赤（危険）
    if (value >= 1.5) return '#fd7e14' // オレンジ（注意）
    if (value >= 1.0) return '#6c757d' // グレー（普通）
    if (value >= 0.5) return '#198754' // 緑（良好）
    return '#20c997' // 水色（優秀）
  }

  interpretRadarValue(value, label) {
    const numValue = parseFloat(value)
    if (label.includes('耐性')) {
      if (numValue >= 2.0) return '優秀'
      if (numValue >= 1.5) return '良好'
      if (numValue >= 1.0) return '普通'
      return '弱い'
    } else {
      if (numValue >= 2.0) return '危険'
      if (numValue >= 1.5) return '注意'
      if (numValue >= 1.0) return '普通'
      return '良好'
    }
  }

  getPokemonColorPalette() {
    return [
      '#FF6B6B', '#4ECDC4', '#45B7D1', '#96CEB4', '#FFEAA7',
      '#DDA0DD', '#98D8C8', '#F7DC6F', '#BB8FCE', '#85C1E9'
    ]
  }

  // エフェクト系メソッド
  addSparkleToChart(canvas) {
    const sparkle = document.createElement('div')
    sparkle.innerHTML = '✨'
    sparkle.style.cssText = `
      position: absolute;
      font-size: 1.2rem;
      pointer-events: none;
      animation: chartSparkle 1s ease-out forwards;
      top: ${Math.random() * 100}%;
      left: ${Math.random() * 100}%;
      z-index: 10;
    `
    
    canvas.parentElement.style.position = 'relative'
    canvas.parentElement.appendChild(sparkle)
    
    setTimeout(() => sparkle.remove(), 1000)
  }

  animateHeatmap(canvas) {
    let opacity = 0
    const animate = () => {
      opacity += 0.05
      canvas.style.opacity = opacity
      
      if (opacity < 1) {
        requestAnimationFrame(animate)
      }
    }
    
    canvas.style.opacity = '0'
    requestAnimationFrame(animate)
  }

  // チャート更新メソッド
  updateCharts(newTeamData) {
    this.teamDataValue = newTeamData
    
    // 既存のチャートを破棄
    Object.values(this.charts).forEach(chart => {
      if (chart) chart.destroy()
    })
    
    // 新しいデータでチャートを再作成
    this.initializeCharts()
  }

  // チャート画像エクスポート機能
  exportCharts() {
    const chartElements = [
      { name: 'type-radar', chart: this.charts.typeRadar, title: 'タイプ相性バランス' },
      { name: 'role-donut', chart: this.charts.roleDonut, title: '役割分布' },
      { name: 'coverage-bar', chart: this.charts.coverageBar, title: 'タイプカバレッジ' },
      { name: 'weakness-heatmap', canvas: this.weaknessHeatmapTarget, title: '弱点ヒートマップ' }
    ]

    chartElements.forEach(element => {
      if (element.chart) {
        // Chart.jsのチャートをエクスポート
        const url = element.chart.toBase64Image()
        this.downloadImage(url, `${element.name}-chart.png`)
      } else if (element.canvas) {
        // Canvasチャートをエクスポート
        const url = element.canvas.toDataURL('image/png')
        this.downloadImage(url, `${element.name}-chart.png`)
      }
    })

    // 成功メッセージ
    this.showExportSuccess()
  }

  downloadImage(url, filename) {
    const link = document.createElement('a')
    link.download = filename
    link.href = url
    document.body.appendChild(link)
    link.click()
    document.body.removeChild(link)
  }

  showExportSuccess() {
    const toast = document.createElement('div')
    toast.innerHTML = '📸 チャート画像を保存したよ〜✨'
    toast.style.cssText = `
      position: fixed;
      top: 20px;
      right: 20px;
      background: linear-gradient(45deg, #28a745, #20c997);
      color: white;
      padding: 1rem 1.5rem;
      border-radius: 12px;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
      z-index: 9999;
      font-weight: 600;
      animation: slideInRight 0.5s ease-out;
    `
    
    document.body.appendChild(toast)
    setTimeout(() => {
      toast.style.animation = 'slideOut 0.5s ease-in forwards'
      setTimeout(() => document.body.removeChild(toast), 500)
    }, 3000)
  }
}

// CSSアニメーションをJavaScriptで追加
if (!document.head.querySelector('#chart-animations')) {
  const style = document.createElement('style')
  style.id = 'chart-animations'
  style.textContent = `
    @keyframes chartSparkle {
      0% {
        opacity: 0;
        transform: scale(0) rotate(0deg);
      }
      50% {
        opacity: 1;
        transform: scale(1) rotate(180deg);
      }
      100% {
        opacity: 0;
        transform: scale(0) rotate(360deg);
      }
    }
  `
  document.head.appendChild(style)
}