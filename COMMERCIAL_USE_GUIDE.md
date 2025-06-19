# 🏢 商用利用ガイド

## ✅ 商用利用可能な無料構成

### 推奨構成
- **Web hosting**: Render (Free Plan)
- **Database**: Supabase (Free Plan)
- **総コスト**: **$0/月**
- **商用利用**: **✅ 完全OK**

## 📋 利用規約の確認

### Render Free Plan
- ✅ 商用利用可能
- ✅ 広告収益OK
- ⚠️ スリープ機能あり（無アクセス時停止）
- 🔄 アップグレード: $7/月でスリープ解除

### Supabase Free Plan  
- ✅ 商用利用可能
- ✅ 広告収益OK
- 📊 500MB ストレージ
- 📈 2つのプロジェクトまで
- 🔄 アップグレード: $25/月で制限解除

## 🚀 広告サイト連携の実装

### 1. トラッキング設定

Google Analytics追加:
```erb
<!-- app/views/layouts/application.html.erb -->
<head>
  <!-- Google Analytics -->
  <script async src="https://www.googletagmanager.com/gtag/js?id=GA_MEASUREMENT_ID"></script>
  <script>
    window.dataLayer = window.dataLayer || [];
    function gtag(){dataLayer.push(arguments);}
    gtag('js', new Date());
    gtag('config', 'GA_MEASUREMENT_ID');
  </script>
</head>
```

### 2. リファラー検知

```ruby
# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  before_action :track_referrer
  
  private
  
  def track_referrer
    if request.referrer&.include?('あなたのメインサイトのドメイン')
      # メインサイトからの流入をトラッキング
      session[:referrer_source] = 'main_site'
    end
  end
end
```

### 3. CTAボタンの設置

メインサイトに設置するHTML:
```html
<div class="pokemon-tracker-cta">
  <h3>🎮 ポケモンナズロック管理ツール</h3>
  <p>手持ちポケモンや捕獲エリアを簡単管理！</p>
  <a href="https://bros-nuzlocke-tracker.onrender.com?ref=main_site" 
     target="_blank" 
     class="btn btn-primary">
     無料で使ってみる →
  </a>
</div>
```

## 📈 収益化の可能性

### 直接収益
- ✅ Googleアドセンス設置可能
- ✅ アフィリエイトリンク設置可能
- ✅ 寄付ボタン設置可能

### 間接収益  
- ✅ メインサイトへの逆流入
- ✅ ブランディング強化
- ✅ ユーザーエンゲージメント向上

## ⚖️ 法的注意事項

### ポケモン関連
- ✅ ファンツール（非営利的使用）
- ⚠️ ポケモン画像は任天堂著作物
- ✅ データ管理機能のみなら問題なし
- 💡 オリジナルアイコン使用を推奨

### プライバシーポリシー
```ruby
# 必要な記載事項
- データ収集内容
- Cookie使用
- Google Analytics使用
- 第三者サービス（Supabase）使用
```

## 🎯 スケーリング計画

### フェーズ1: 無料運用
- 月間1000PV程度まで
- コスト: $0

### フェーズ2: 軽量有料
- Render $7/月（スリープ解除）
- 月間10,000PV程度まで

### フェーズ3: 本格運用
- Supabase Pro: $25/月
- CDN追加、パフォーマンス最適化

### フェーズ4: 完全商用
- AWS/GCP移行
- 独自ドメイン
- SSL証明書

## 🔧 実装チェックリスト

- [ ] Google Analytics設定
- [ ] プライバシーポリシー作成
- [ ] リファラートラッキング実装
- [ ] メインサイトにCTA設置
- [ ] 利用規約作成（必要に応じて）
- [ ] 広告設置（Google AdSense等）

---

この構成で完全に商用利用可能だよ！💪✨
