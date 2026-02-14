import { Controller } from "@hotwired/stimulus"

// 折りたたみセクションコントローラー
// フォームの上級者向けセクション（IV/EV等）を折りたたむ
export default class extends Controller {
  static targets = ["content", "toggle", "icon"]
  static values = { open: { type: Boolean, default: false } }

  connect() {
    this.update()
  }

  toggle() {
    this.openValue = !this.openValue
    this.update()
  }

  update() {
    if (this.hasContentTarget) {
      this.contentTarget.style.display = this.openValue ? "block" : "none"
    }
    if (this.hasToggleTarget) {
      this.toggleTarget.textContent = this.openValue ? "▼ 閉じる" : "▶ 開く"
    }
    if (this.hasIconTarget) {
      this.iconTarget.textContent = this.openValue ? "▼" : "▶"
    }
  }
}
