// Turbo パフォーマンス最適化設定 🚀
// ページ遷移の高速化に特化

import { Turbo } from "@hotwired/turbo-rails"

// プログレスバーを素早く表示（体感速度向上）
Turbo.setProgressBarDelay(100)

// Turbo Drive のプリフェッチを有効化
// ホバー時にリンク先を事前読み込みして体感速度UP
document.addEventListener('turbo:load', () => {
  // 内部リンクに data-turbo-prefetch を自動追加
  document.querySelectorAll('a[href^="/"]').forEach(link => {
    // 既に設定済み、またはTurbo無効のリンクはスキップ
    if (link.dataset.turboPrefetch || link.dataset.turbo === 'false') return
    // フォーム送信ボタン的リンクはスキップ
    if (link.dataset.turboMethod) return
    
    link.dataset.turboPrefetch = ''
  })
})

// ページキャッシュ最適化
document.addEventListener('turbo:before-cache', () => {
  // アクティブな要素からフォーカスを外す
  if (document.activeElement && document.activeElement.blur) {
    document.activeElement.blur()
  }
  
  // トースト通知を削除（キャッシュに含めない）
  document.querySelectorAll('.toast-notification').forEach(el => el.remove())
})

// ページ読み込み後の最適化
document.addEventListener('turbo:load', () => {
  // オートフォーカス
  const autofocusElement = document.querySelector('[autofocus]')
  if (autofocusElement) {
    autofocusElement.focus()
  }
})

// エラーハンドリング
document.addEventListener('turbo:fetch-request-error', (event) => {
  console.warn('Turbo request failed:', event.detail?.url)
})
