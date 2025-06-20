// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "./turbo_performance"

// スムーズなページ遷移のための即座反応設定
document.addEventListener('turbo:click', (event) => {
  // クリック時に即座に視覚的フィードバック
  const target = event.target.closest('a, button')
  if (target && !target.disabled) {
    target.style.opacity = '0.8'
    target.style.transform = 'scale(0.98)'
    setTimeout(() => {
      if (target) {
        target.style.opacity = ''
        target.style.transform = ''
      }
    }, 120)
  }
})
