// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "./turbo_performance"

// クリック時の視覚フィードバック（CSSクラスベースでCSP準拠）
document.addEventListener('turbo:click', (event) => {
  const target = event.target.closest('a, button')
  if (target && !target.disabled) {
    target.classList.add('turbo-clicking')
    setTimeout(() => target.classList.remove('turbo-clicking'), 150)
  }
})
