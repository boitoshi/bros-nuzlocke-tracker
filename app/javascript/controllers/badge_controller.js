import { Controller } from "@hotwired/stimulus"

// バッジ・マイルストーンの非同期トグルコントローラー 🏅
// ページリロードなしでバッジ達成/未達成を切り替える
export default class extends Controller {
  static targets = ["icon", "label", "date", "count"]
  static values = {
    url: String,
    completed: Boolean,
    name: String
  }

  async toggle(event) {
    event.preventDefault()
    const btn = event.currentTarget
    btn.disabled = true

    // 楽観的UI更新
    const wasCompleted = this.completedValue
    this.completedValue = !wasCompleted
    this.updateUI()

    try {
      const csrfToken = document.querySelector('meta[name="csrf-token"]')?.content
      const response = await fetch(this.urlValue, {
        method: 'PATCH',
        headers: {
          'X-CSRF-Token': csrfToken,
          'Accept': 'application/json',
          'X-Requested-With': 'XMLHttpRequest'
        }
      })

      if (!response.ok) {
        // 失敗したら元に戻す
        this.completedValue = wasCompleted
        this.updateUI()
      } else {
        const data = await response.json()
        this.completedValue = data.completed
        this.updateUI(data.completed_date)
        // バッジカウントを更新
        this.updateBadgeCount(data)
      }
    } catch (error) {
      this.completedValue = wasCompleted
      this.updateUI()
      console.error("Badge toggle failed:", error)
    } finally {
      btn.disabled = false
    }
  }

  updateUI(dateStr) {
    if (this.completedValue) {
      this.element.classList.add("badge-completed")
      this.element.classList.remove("badge-incomplete")
      if (this.hasIconTarget) this.iconTarget.textContent = "🏅"
      if (this.hasDateTarget && dateStr) this.dateTarget.textContent = dateStr
    } else {
      this.element.classList.remove("badge-completed")
      this.element.classList.add("badge-incomplete")
      if (this.hasIconTarget) this.iconTarget.textContent = "⬜"
      if (this.hasDateTarget) this.dateTarget.textContent = ""
    }
  }

  updateBadgeCount(data) {
    // ページ全体のバッジカウンターを更新
    if (data.category_completed !== undefined && data.category_total !== undefined) {
      const counterId = `badge-counter-${data.category}`
      const counter = document.getElementById(counterId)
      if (counter) {
        counter.textContent = `${data.category_completed}/${data.category_total}`
      }
    }
  }
}
