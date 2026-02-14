import { Controller } from "@hotwired/stimulus"

// カード上でレベルを即座に変更するコントローラー
// フルページリロードなしで+/-を反映する
export default class extends Controller {
  static targets = ["display", "minusBtn", "plusBtn"]
  static values = { 
    url: String,
    level: Number,
    min: { type: Number, default: 1 },
    max: { type: Number, default: 100 }
  }

  increment(event) {
    event.preventDefault()
    this.changeLevel(this.levelValue + 1)
  }

  decrement(event) {
    event.preventDefault()
    this.changeLevel(this.levelValue - 1)
  }

  async changeLevel(newLevel) {
    if (newLevel < this.minValue || newLevel > this.maxValue) return

    // 即座にUI更新（楽観的更新）
    const oldLevel = this.levelValue
    this.levelValue = newLevel
    this.updateDisplay()

    try {
      const csrfToken = document.querySelector('meta[name="csrf-token"]')?.content
      const response = await fetch(`${this.urlValue}?level=${newLevel}`, {
        method: 'PATCH',
        headers: {
          'X-CSRF-Token': csrfToken,
          'Accept': 'application/json',
          'X-Requested-With': 'XMLHttpRequest'
        }
      })

      if (!response.ok) {
        // 失敗したら元に戻す
        this.levelValue = oldLevel
        this.updateDisplay()
      }
    } catch (error) {
      // ネットワークエラー時も元に戻す
      this.levelValue = oldLevel
      this.updateDisplay()
    }
  }

  updateDisplay() {
    if (this.hasDisplayTarget) {
      this.displayTarget.textContent = `Lv.${this.levelValue}`
    }
    if (this.hasMinusBtnTarget) {
      this.minusBtnTarget.disabled = this.levelValue <= this.minValue
    }
    if (this.hasPlusBtnTarget) {
      this.plusBtnTarget.disabled = this.levelValue >= this.maxValue
    }
  }
}
