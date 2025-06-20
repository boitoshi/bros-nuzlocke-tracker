import { Controller } from "@hotwired/stimulus"
import { Chart, registerables } from "chart.js"

// Chart.jsの全機能を登録
Chart.register(...registerables)

export default class extends Controller {
  static targets = [
    "monthlyChart", "popularPokemonChart", "survivalTypeChart", 
    "survivalLevelChart", "areaDangerChart", "overallStatsCard"
  ]
  
  static values = { 
    monthlyData: Array,
    popularPokemon: Array,
    survivalAnalysis: Object,
    areaDangerMap: Array,
    overallStats: Object
  }

  connect() {
    console.log("📊 Statistics Dashboard ready! 統計の魔法を見せるよ〜✨")
    this.charts = {}
    this.pokemonColors = this.getPokemonColorPalette()
    this.initializeAllCharts()
    this.animateStatsCards()
  }

  disconnect() {
    // チャートのクリーンアップ
    Object.values(this.charts).forEach(chart => {
      if (chart) chart.destroy()
    })
  }

  initializeAllCharts() {
    // データが存在する場合のみチャートを初期化
    if (this.monthlyDataValue && this.monthlyDataValue.length > 0) {
      this.createMonthlyTrendsChart()
    }
    
    if (this.popularPokemonValue && this.popularPokemonValue.length > 0) {
      this.createPopularPokemonChart()
    }
    
    if (this.survivalAnalysisValue && Object.keys(this.survivalAnalysisValue).length > 0) {
      this.createSurvivalTypeChart()
      this.createSurvivalLevelChart()
    }
    
    if (this.areaDangerMapValue && this.areaDangerMapValue.length > 0) {
      this.createAreaDangerChart()
    }
  }

  // 📈 月別トレンドチャート（複合グラフ）
  createMonthlyTrendsChart() {
    if (!this.hasMonthlyChartTarget) return

    const ctx = this.monthlyChartTarget.getContext('2d')
    const data = this.monthlyDataValue

    this.charts.monthly = new Chart(ctx, {
      type: 'line',
      data: {
        labels: data.map(d => d.month_name),
        datasets: [
          {
            type: 'bar',
            label: 'ポケモン捕獲',
            data: data.map(d => d.pokemon_caught),
            backgroundColor: 'rgba(40, 167, 69, 0.6)',
            borderColor: 'rgba(40, 167, 69, 1)',
            borderWidth: 2,
            yAxisID: 'y',
            borderRadius: 6,
            borderSkipped: false
          },
          {
            type: 'bar', 
            label: 'ポケモン死亡',
            data: data.map(d => d.pokemon_died),
            backgroundColor: 'rgba(220, 53, 69, 0.6)',
            borderColor: 'rgba(220, 53, 69, 1)',
            borderWidth: 2,
            yAxisID: 'y',
            borderRadius: 6,
            borderSkipped: false
          },
          {
            type: 'line',
            label: '生存率',
            data: data.map(d => d.survival_rate),
            borderColor: 'rgba(255, 193, 7, 1)',
            backgroundColor: 'rgba(255, 193, 7, 0.1)',
            borderWidth: 4,
            fill: true,
            tension: 0.4,
            pointBackgroundColor: 'rgba(255, 193, 7, 1)',
            pointBorderColor: '#fff',
            pointBorderWidth: 3,
            pointRadius: 6,
            pointHoverRadius: 8,
            yAxisID: 'y1'
          },
          {
            type: 'line',
            label: 'ジム戦',
            data: data.map(d => d.gym_battles),
            borderColor: 'rgba(32, 201, 151, 1)',
            backgroundColor: 'rgba(32, 201, 151, 0.1)',
            borderWidth: 3,
            fill: false,
            tension: 0.3,
            pointBackgroundColor: 'rgba(32, 201, 151, 1)',
            pointBorderColor: '#fff',
            pointBorderWidth: 2,
            pointRadius: 5,
            pointHoverRadius: 7,
            yAxisID: 'y'
          }
        ]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        animation: {
          duration: 2500,
          easing: 'easeInOutQuart'
        },
        plugins: {
          legend: {
            position: 'top',
            labels: {
              padding: 20,
              font: {
                size: 13,
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
              title: (context) => {
                return `📅 ${context[0].label}`
              },
              label: (context) => {
                const label = context.dataset.label
                const value = context.parsed.y
                
                if (label === '生存率') {
                  return `${label}: ${value}% 🎯`
                } else if (label === 'ポケモン捕獲') {
                  return `${label}: ${value}匹 ⚾`
                } else if (label === 'ポケモン死亡') {
                  return `${label}: ${value}匹 💀`
                } else if (label === 'ジム戦') {
                  return `${label}: ${value}回 🏟️`
                }
                return `${label}: ${value}`
              }
            }
          }
        },
        scales: {
          x: {
            grid: {
              color: 'rgba(0, 0, 0, 0.1)'
            },
            ticks: {
              font: {
                size: 12,
                weight: '500'
              },
              color: '#495057'
            }
          },
          y: {
            type: 'linear',
            display: true,
            position: 'left',
            beginAtZero: true,
            grid: {
              color: 'rgba(0, 0, 0, 0.1)'
            },
            ticks: {
              font: {
                size: 11
              },
              color: '#6c757d'
            },
            title: {
              display: true,
              text: '匹数・回数',
              font: {
                size: 12,
                weight: '600'
              },
              color: '#495057'
            }
          },
          y1: {
            type: 'linear',
            display: true,
            position: 'right',
            beginAtZero: true,
            max: 100,
            grid: {
              drawOnChartArea: false,
            },
            ticks: {
              font: {
                size: 11
              },
              color: '#6c757d',
              callback: function(value) {
                return value + '%'
              }
            },
            title: {
              display: true,
              text: '生存率 (%)',
              font: {
                size: 12,
                weight: '600'
              },
              color: '#495057'
            }
          }
        },
        interaction: {
          intersect: false,
          mode: 'index'
        }
      }
    })
  }

  // 🏆 人気ポケモンランキングチャート（横棒グラフ）
  createPopularPokemonChart() {
    if (!this.hasPopularPokemonChartTarget) return

    const ctx = this.popularPokemonChartTarget.getContext('2d')
    const data = this.popularPokemonValue.slice(0, 8) // 上位8匹

    this.charts.popularPokemon = new Chart(ctx, {
      type: 'bar',
      data: {
        labels: data.map(p => `${p.species} (${p.primary_type})`),
        datasets: [
          {
            label: '生存',
            data: data.map(p => p.alive_count),
            backgroundColor: 'rgba(40, 167, 69, 0.8)',
            borderColor: 'rgba(40, 167, 69, 1)',
            borderWidth: 2,
            borderRadius: 8,
            borderSkipped: false
          },
          {
            label: '死亡',
            data: data.map(p => p.dead_count),
            backgroundColor: 'rgba(220, 53, 69, 0.8)',
            borderColor: 'rgba(220, 53, 69, 1)',
            borderWidth: 2,
            borderRadius: 8,
            borderSkipped: false
          }
        ]
      },
      options: {
        indexAxis: 'y', // 横棒グラフ
        responsive: true,
        maintainAspectRatio: false,
        animation: {
          duration: 2000,
          easing: 'easeOutBounce'
        },
        plugins: {
          legend: {
            position: 'top',
            labels: {
              padding: 15,
              font: {
                size: 13,
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
              title: (context) => {
                const pokemonData = data[context[0].dataIndex]
                return `🌟 ${pokemonData.species} (${pokemonData.primary_type})`
              },
              label: (context) => {
                const pokemonData = data[context.dataIndex]
                const label = context.dataset.label
                const value = context.parsed.x
                const total = pokemonData.total_count
                const percentage = total > 0 ? ((value / total) * 100).toFixed(1) : 0
                
                return `${label}: ${value}匹 (${percentage}%)`
              },
              afterBody: (context) => {
                const pokemonData = data[context[0].dataIndex]
                return [
                  `総使用回数: ${pokemonData.total_count}匹`,
                  `生存率: ${pokemonData.survival_rate}%`
                ]
              }
            }
          }
        },
        scales: {
          x: {
            stacked: true,
            beginAtZero: true,
            grid: {
              color: 'rgba(0, 0, 0, 0.1)'
            },
            ticks: {
              font: {
                size: 11
              },
              color: '#6c757d'
            },
            title: {
              display: true,
              text: '使用回数',
              font: {
                size: 12,
                weight: '600'
              },
              color: '#495057'
            }
          },
          y: {
            stacked: true,
            grid: {
              display: false
            },
            ticks: {
              font: {
                size: 12,
                weight: '500'
              },
              color: '#495057'
            }
          }
        }
      }
    })
  }

  // 🔥 タイプ別生存率チャート（レーダーチャート）
  createSurvivalTypeChart() {
    if (!this.hasSurvivalTypeChartTarget || !this.survivalAnalysisValue.type_survival) return

    const ctx = this.survivalTypeChartTarget.getContext('2d')
    const typeData = this.survivalAnalysisValue.type_survival
    
    const types = Object.keys(typeData)
    const survivalRates = types.map(type => typeData[type].survival_rate)
    const totals = types.map(type => typeData[type].total)

    this.charts.survivalType = new Chart(ctx, {
      type: 'radar',
      data: {
        labels: types.map(type => type.charAt(0).toUpperCase() + type.slice(1)),
        datasets: [
          {
            label: '生存率',
            data: survivalRates,
            backgroundColor: 'rgba(54, 162, 235, 0.2)',
            borderColor: 'rgba(54, 162, 235, 1)',
            borderWidth: 3,
            pointBackgroundColor: 'rgba(54, 162, 235, 1)',
            pointBorderColor: '#fff',
            pointBorderWidth: 2,
            pointRadius: 6,
            pointHoverRadius: 8,
            fill: true
          },
          {
            label: '使用回数',
            data: totals.map(total => Math.min(total * 10, 100)), // スケール調整
            backgroundColor: 'rgba(255, 99, 132, 0.2)',
            borderColor: 'rgba(255, 99, 132, 1)',
            borderWidth: 2,
            pointBackgroundColor: 'rgba(255, 99, 132, 1)',
            pointBorderColor: '#fff',
            pointBorderWidth: 2,
            pointRadius: 4,
            pointHoverRadius: 6,
            fill: true
          }
        ]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        animation: {
          duration: 2200,
          easing: 'easeInOutElastic'
        },
        scales: {
          r: {
            beginAtZero: true,
            max: 100,
            ticks: {
              stepSize: 20,
              font: {
                size: 11
              },
              color: '#6c757d',
              backdropColor: 'rgba(255, 255, 255, 0.8)'
            },
            grid: {
              color: 'rgba(0, 0, 0, 0.1)'
            },
            angleLines: {
              color: 'rgba(0, 0, 0, 0.1)'
            },
            pointLabels: {
              font: {
                size: 12,
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
                size: 13,
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
                const typeIndex = context.dataIndex
                const typeName = types[typeIndex]
                const typeInfo = typeData[typeName]
                
                if (context.datasetIndex === 0) {
                  return `生存率: ${typeInfo.survival_rate}% (${typeInfo.alive}/${typeInfo.total})`
                } else {
                  return `使用回数: ${typeInfo.total}匹`
                }
              }
            }
          }
        }
      }
    })
  }

  // 📊 レベル別生存率チャート（棒グラフ）
  createSurvivalLevelChart() {
    if (!this.hasSurvivalLevelChartTarget || !this.survivalAnalysisValue.level_survival) return

    const ctx = this.survivalLevelChartTarget.getContext('2d')
    const levelData = this.survivalAnalysisValue.level_survival

    this.charts.survivalLevel = new Chart(ctx, {
      type: 'bar',
      data: {
        labels: levelData.map(d => d.level_range),
        datasets: [
          {
            label: '生存率',
            data: levelData.map(d => d.survival_rate),
            backgroundColor: levelData.map(d => {
              const rate = d.survival_rate
              if (rate >= 80) return 'rgba(40, 167, 69, 0.8)'
              if (rate >= 60) return 'rgba(255, 193, 7, 0.8)'
              if (rate >= 40) return 'rgba(255, 159, 64, 0.8)'
              return 'rgba(220, 53, 69, 0.8)'
            }),
            borderColor: levelData.map(d => {
              const rate = d.survival_rate
              if (rate >= 80) return 'rgba(40, 167, 69, 1)'
              if (rate >= 60) return 'rgba(255, 193, 7, 1)'
              if (rate >= 40) return 'rgba(255, 159, 64, 1)'
              return 'rgba(220, 53, 69, 1)'
            }),
            borderWidth: 2,
            borderRadius: 8,
            borderSkipped: false
          }
        ]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        animation: {
          duration: 2000,
          easing: 'easeOutBounce'
        },
        plugins: {
          legend: {
            display: false
          },
          tooltip: {
            backgroundColor: 'rgba(0, 0, 0, 0.8)',
            titleColor: '#fff',
            bodyColor: '#fff',
            borderColor: 'rgba(255, 255, 255, 0.2)',
            borderWidth: 1,
            cornerRadius: 8,
            callbacks: {
              title: (context) => {
                const data = levelData[context[0].dataIndex]
                return `📈 ${data.level_range}`
              },
              label: (context) => {
                const data = levelData[context.dataIndex]
                return [
                  `生存率: ${data.survival_rate}%`,
                  `生存: ${data.alive}匹`,
                  `死亡: ${data.dead}匹`,
                  `総数: ${data.total}匹`
                ]
              }
            }
          }
        },
        scales: {
          x: {
            grid: {
              display: false
            },
            ticks: {
              font: {
                size: 12,
                weight: '500'
              },
              color: '#495057'
            }
          },
          y: {
            beginAtZero: true,
            max: 100,
            grid: {
              color: 'rgba(0, 0, 0, 0.1)'
            },
            ticks: {
              font: {
                size: 11
              },
              color: '#6c757d',
              callback: function(value) {
                return value + '%'
              }
            },
            title: {
              display: true,
              text: '生存率 (%)',
              font: {
                size: 12,
                weight: '600'
              },
              color: '#495057'
            }
          }
        }
      }
    })
  }

  // 🗺️ エリア別危険度チャート（ドーナツチャート）
  createAreaDangerChart() {
    if (!this.hasAreaDangerChartTarget) return

    const ctx = this.areaDangerChartTarget.getContext('2d')
    const areaData = this.areaDangerMapValue.slice(0, 10) // 上位10エリア

    const dangerColors = {
      'safe': 'rgba(40, 167, 69, 0.8)',
      'low': 'rgba(32, 201, 151, 0.8)',
      'medium': 'rgba(255, 193, 7, 0.8)',
      'high': 'rgba(255, 159, 64, 0.8)',
      'critical': 'rgba(220, 53, 69, 0.8)'
    }

    this.charts.areaDanger = new Chart(ctx, {
      type: 'doughnut',
      data: {
        labels: areaData.map(area => area.area_name),
        datasets: [{
          data: areaData.map(area => area.death_rate),
          backgroundColor: areaData.map(area => dangerColors[area.danger_level]),
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
          duration: 2500,
          easing: 'easeInOutElastic'
        },
        plugins: {
          legend: {
            position: 'right',
            labels: {
              padding: 15,
              font: {
                size: 12,
                weight: '500'
              },
              usePointStyle: true,
              pointStyle: 'circle',
              generateLabels: function(chart) {
                const original = Chart.defaults.plugins.legend.labels.generateLabels
                const labels = original.call(this, chart)
                
                labels.forEach((label, index) => {
                  const area = areaData[index]
                  if (area) {
                    label.text += ` (${area.death_rate}%)`
                  }
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
              title: (context) => {
                const area = areaData[context[0].dataIndex]
                return `🗺️ ${area.area_name}`
              },
              label: (context) => {
                const area = areaData[context.dataIndex]
                return [
                  `死亡率: ${area.death_rate}%`,
                  `危険度: ${this.getDangerLevelText(area.danger_level)}`,
                  `死亡: ${area.dead_pokemon}匹`,
                  `総数: ${area.total_pokemon}匹`,
                  `安全度: ${area.safety_score}%`
                ]
              }
            }
          }
        },
        onHover: (event, elements) => {
          if (elements.length > 0) {
            this.addSparkleToChart(this.areaDangerChartTarget)
          }
        }
      }
    })
  }

  // 📋 統計カードのアニメーション
  animateStatsCards() {
    if (!this.hasOverallStatsCardTarget) return

    const stats = this.overallStatsValue
    if (!stats) return

    // カウントアップアニメーション
    this.animateCountUp('total-challenges', 0, stats.total_challenges, 1500)
    this.animateCountUp('total-pokemon', 0, stats.total_pokemon_caught, 2000)
    this.animateCountUp('survival-rate', 0, stats.overall_survival_rate, 2500, '%')
    this.animateCountUp('total-events', 0, stats.total_events, 1800)
  }

  animateCountUp(elementId, start, end, duration, suffix = '') {
    const element = document.getElementById(elementId)
    if (!element) return

    const startTime = performance.now()
    const animate = (currentTime) => {
      const elapsed = currentTime - startTime
      const progress = Math.min(elapsed / duration, 1)
      
      const current = Math.floor(start + (end - start) * this.easeOutQuart(progress))
      element.textContent = current.toLocaleString() + suffix
      
      if (progress < 1) {
        requestAnimationFrame(animate)
      }
    }
    
    requestAnimationFrame(animate)
  }

  easeOutQuart(t) {
    return 1 - Math.pow(1 - t, 4)
  }

  // ユーティリティメソッド
  getPokemonColorPalette() {
    return [
      '#FF6B6B', '#4ECDC4', '#45B7D1', '#96CEB4', '#FFEAA7',
      '#DDA0DD', '#98D8C8', '#F7DC6F', '#BB8FCE', '#85C1E9',
      '#F8C471', '#82E0AA', '#AED6F1', '#F1948A', '#D7BDE2'
    ]
  }

  getDangerLevelText(level) {
    const levels = {
      'safe': '安全 🟢',
      'low': '低危険 🟡',
      'medium': '中危険 🟠',
      'high': '高危険 🔴',
      'critical': '超危険 💀'
    }
    return levels[level] || level
  }

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

  // チャート更新メソッド
  refreshCharts() {
    // 既存のチャートを破棄
    Object.values(this.charts).forEach(chart => {
      if (chart) chart.destroy()
    })
    
    // チャートを再作成
    this.initializeAllCharts()
    this.animateStatsCards()
    
    // 成功メッセージ
    this.showRefreshSuccess()
  }

  showRefreshSuccess() {
    const toast = document.createElement('div')
    toast.innerHTML = '📊 統計データを更新したよ〜✨'
    toast.style.cssText = `
      position: fixed;
      top: 20px;
      right: 20px;
      background: linear-gradient(45deg, #667eea, #764ba2);
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
if (!document.head.querySelector('#statistics-animations')) {
  const style = document.createElement('style')
  style.id = 'statistics-animations'
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
    
    @keyframes slideInRight {
      0% {
        opacity: 0;
        transform: translateX(100%);
      }
      100% {
        opacity: 1;
        transform: translateX(0);
      }
    }
    
    @keyframes slideOut {
      0% {
        opacity: 1;
        transform: translateX(0);
      }
      100% {
        opacity: 0;
        transform: translateX(100%);
      }
    }
  `
  document.head.appendChild(style)
}