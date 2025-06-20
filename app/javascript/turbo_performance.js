// Turbo パフォーマンス最適化設定 🚀
// 最新のベストプラクティスを適用

import { Turbo } from "@hotwired/turbo-rails"

// 高速化設定
Turbo.setProgressBarDelay(50) // プログレスバー表示を早く
Turbo.setFormMode("off") // フォーム送信でページ全体リロードを避ける

// プリロード機能（ホバー時）
document.addEventListener('turbo:load', () => {
  // リンクにホバーした時にプリロード
  document.querySelectorAll('a[href^="/"]').forEach(link => {
    let timeout
    
    link.addEventListener('mouseenter', () => {
      timeout = setTimeout(() => {
        if (!link.dataset.turboPreload) {
          link.dataset.turboPreload = 'true'
          // バックグラウンドでページを事前読み込み
          fetch(link.href, {
            method: 'GET',
            headers: {
              'Accept': 'text/html'
            }
          }).catch(() => {
            // エラーは無視（プリロードなので）
          })
        }
      }, 100) // 100ms後にプリロード開始
    })
    
    link.addEventListener('mouseleave', () => {
      clearTimeout(timeout)
    })
  })
})

// ページキャッシュ最適化
document.addEventListener('turbo:before-cache', () => {
  // スクロール位置をリセット
  window.scrollTo(0, 0)
  
  // アクティブな要素からフォーカスを外す
  if (document.activeElement && document.activeElement.blur) {
    document.activeElement.blur()
  }
  
  // アニメーションを停止
  document.querySelectorAll('[style*="animation"]').forEach(el => {
    el.style.animation = 'none'
  })
})

// ページ読み込み後の最適化
document.addEventListener('turbo:load', () => {
  // 画像遅延読み込み
  if ('IntersectionObserver' in window) {
    const imageObserver = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          const img = entry.target
          if (img.dataset.src) {
            img.src = img.dataset.src
            img.removeAttribute('data-src')
            imageObserver.unobserve(img)
          }
        }
      })
    })
    
    document.querySelectorAll('img[data-src]').forEach(img => {
      imageObserver.observe(img)
    })
  }
  
  // フォーカス管理
  const autofocusElement = document.querySelector('[autofocus]')
  if (autofocusElement) {
    autofocusElement.focus()
  }
})

// エラーハンドリング
document.addEventListener('turbo:fetch-request-error', (event) => {
  console.warn('Turbo request failed:', event.detail.url)
})