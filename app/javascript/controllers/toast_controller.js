import { Controller } from "@hotwired/stimulus"

// 🍞 トースト通知コントローラー
// フラッシュメッセージを自動で消えるトースト形式で表示
export default class extends Controller {
  static values = {
    duration: { type: Number, default: 5000 },  // 表示時間（ms）
    type: { type: String, default: "success" }   // success / error / info / warning
  }

  connect() {
    // 表示アニメーション
    requestAnimationFrame(() => {
      this.element.classList.add("toast-show")
    })

    // 自動消去タイマー
    this.autoDismissTimer = setTimeout(() => {
      this.dismiss()
    }, this.durationValue)

    // プログレスバーアニメーション
    const progressBar = this.element.querySelector('.toast-progress')
    if (progressBar) {
      progressBar.style.animationDuration = `${this.durationValue}ms`
    }
  }

  disconnect() {
    if (this.autoDismissTimer) {
      clearTimeout(this.autoDismissTimer)
    }
  }

  // 手動で閉じる
  dismiss() {
    this.element.classList.add("toast-hide")
    this.element.addEventListener("animationend", () => {
      this.element.remove()
    }, { once: true })
  }

  // マウスホバーでタイマー一時停止
  pause() {
    if (this.autoDismissTimer) {
      clearTimeout(this.autoDismissTimer)
    }
    const progressBar = this.element.querySelector('.toast-progress')
    if (progressBar) {
      progressBar.style.animationPlayState = 'paused'
    }
  }

  // マウスが離れたらタイマー再開
  resume() {
    this.autoDismissTimer = setTimeout(() => {
      this.dismiss()
    }, 2000) // ホバー後は2秒で消える
    const progressBar = this.element.querySelector('.toast-progress')
    if (progressBar) {
      progressBar.style.animationPlayState = 'running'
    }
  }
}
