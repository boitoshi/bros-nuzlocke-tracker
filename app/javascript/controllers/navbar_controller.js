import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["collapse", "toggler"]
  
  connect() {
    console.log("🧭 Modern Navbar Controller ready! ナビゲーションが動くよ〜✨")
    
    // ハンバーガーメニューのクリックイベント
    if (this.hasTogglerTarget) {
      this.togglerTarget.addEventListener('click', this.toggle.bind(this))
    }
    
    // スクロール時のナビゲーション効果
    this.handleScroll = this.handleScroll.bind(this)
    window.addEventListener('scroll', this.handleScroll)
    
    // 外側クリック時にメニューを閉じる
    document.addEventListener('click', this.closeOnOutsideClick.bind(this))
  }
  
  disconnect() {
    window.removeEventListener('scroll', this.handleScroll)
    document.removeEventListener('click', this.closeOnOutsideClick)
  }
  
  // ハンバーガーメニューの開閉
  toggle(event) {
    event.preventDefault()
    
    const isExpanded = this.togglerTarget.getAttribute('aria-expanded') === 'true'
    const newState = !isExpanded
    
    // aria-expanded属性を更新
    this.togglerTarget.setAttribute('aria-expanded', newState)
    
    if (this.hasCollapseTarget) {
      if (newState) {
        this.openMenu()
      } else {
        this.closeMenu()
      }
    }
  }
  
  // メニューを開く
  openMenu() {
    this.collapseTarget.classList.add('collapsing')
    this.collapseTarget.classList.remove('collapse')
    
    // アニメーションのため少し遅らせてshowクラスを追加
    setTimeout(() => {
      this.collapseTarget.classList.remove('collapsing')
      this.collapseTarget.classList.add('collapse', 'show')
    }, 300)
    
    // ボディスクロールを無効化（モバイル用）
    if (window.innerWidth < 992) {
      document.body.style.overflow = 'hidden'
    }
  }
  
  // メニューを閉じる
  closeMenu() {
    this.collapseTarget.classList.add('collapsing')
    this.collapseTarget.classList.remove('show')
    
    setTimeout(() => {
      this.collapseTarget.classList.remove('collapsing')
      this.collapseTarget.classList.add('collapse')
    }, 300)
    
    // aria-expanded属性を更新
    this.togglerTarget.setAttribute('aria-expanded', 'false')
    
    // ボディスクロールを復元
    document.body.style.overflow = ''
  }
  
  // 外側クリック時にメニューを閉じる
  closeOnOutsideClick(event) {
    if (!this.element.contains(event.target) && this.hasCollapseTarget) {
      if (this.collapseTarget.classList.contains('show')) {
        this.closeMenu()
      }
    }
  }
  
  // ナビゲーションリンククリック時にメニューを閉じる（モバイル用）
  closeMenuOnLinkClick(event) {
    if (window.innerWidth < 992 && this.hasCollapseTarget) {
      if (this.collapseTarget.classList.contains('show')) {
        // 少し遅らせてメニューを閉じる（ナビゲーションの後）
        setTimeout(() => {
          this.closeMenu()
        }, 150)
      }
    }
  }
  
  // スクロール時のナビゲーション効果
  handleScroll() {
    const navbar = this.element
    const scrollY = window.scrollY
    
    if (scrollY > 50) {
      navbar.classList.add('scrolled')
    } else {
      navbar.classList.remove('scrolled')
    }
  }
  
  // ユーザードロップダウンの制御
  toggleUserDropdown(event) {
    event.preventDefault()
    const dropdown = event.currentTarget.nextElementSibling
    
    if (dropdown && dropdown.classList.contains('dropdown-menu')) {
      const isShown = dropdown.classList.contains('show')
      
      // 他のドロップダウンを閉じる
      document.querySelectorAll('.dropdown-menu.show').forEach(menu => {
        if (menu !== dropdown) {
          menu.classList.remove('show')
        }
      })
      
      // 現在のドロップダウンをトグル
      dropdown.classList.toggle('show', !isShown)
      event.currentTarget.setAttribute('aria-expanded', !isShown)
    }
  }
  
  // スムーズスクロール機能
  smoothScrollTo(target) {
    const element = document.querySelector(target)
    if (element) {
      const headerHeight = this.element.offsetHeight
      const targetPosition = element.offsetTop - headerHeight - 20
      
      window.scrollTo({
        top: targetPosition,
        behavior: 'smooth'
      })
    }
  }
  
  // モバイルメニューアニメーション
  addMenuAnimation() {
    if (this.hasCollapseTarget) {
      const menuItems = this.collapseTarget.querySelectorAll('.nav-item')
      
      menuItems.forEach((item, index) => {
        item.style.animation = `navSlideIn 0.3s ease-out ${index * 0.1}s both`
      })
    }
  }
}