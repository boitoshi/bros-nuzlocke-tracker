import { Controller } from "@hotwired/stimulus"

// ナズロックルール捕獲チェックコントローラー
// 各エリアで1匹のみ捕獲可能ルールをリアルタイムで警告
export default class extends Controller {
  static targets = ["select", "warning", "submit"]
  static values = {
    caughtAreas: Object  // { area_id: { name: "ポケモン名", status: "alive/dead/boxed" } }
  }

  connect() {
    this.checkArea()
  }

  checkArea() {
    const selectedAreaId = this.selectTarget.value
    const warningEl = this.warningTarget

    if (!selectedAreaId || !this.hasCaughtAreasValue) {
      warningEl.classList.add("d-none")
      this.enableSubmit()
      return
    }

    const caught = this.caughtAreasValue[selectedAreaId]

    if (caught) {
      const statusLabel = this.statusLabel(caught.status)
      const statusIcon = this.statusIcon(caught.status)

      warningEl.innerHTML = `
        <div class="d-flex align-items-start">
          <span class="fs-4 me-2">⚠️</span>
          <div>
            <strong>ナズロックルール違反の可能性</strong>
            <p class="mb-1">このエリアではすでに <strong>${caught.name}</strong> を捕獲しています。</p>
            <small class="text-muted">
              ${statusIcon} 現在のステータス: ${statusLabel}
              ${caught.status === 'dead' ? '（死亡済みでも同じエリアでの再捕獲はルール違反です）' : ''}
            </small>
          </div>
        </div>
      `
      warningEl.classList.remove("d-none")
      // 警告は出すが送信は可能（ユーザーの判断に委ねる - 特殊ルール対応）
      // ただしバリデーションでブロックされる
    } else {
      warningEl.classList.add("d-none")
      this.enableSubmit()
    }
  }

  enableSubmit() {
    if (this.hasSubmitTarget) {
      this.submitTarget.disabled = false
    }
  }

  statusLabel(status) {
    const labels = {
      alive: "生存中",
      dead: "死亡",
      boxed: "ボックス保管"
    }
    return labels[status] || status
  }

  statusIcon(status) {
    const icons = {
      alive: "💚",
      dead: "💀",
      boxed: "📦"
    }
    return icons[status] || "❓"
  }
}
