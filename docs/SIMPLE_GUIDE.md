# 📚 アプリケーション構成ガイド

## 🎯 このアプリの目的
ポケモンナズロックチャレンジの記録・管理を簡単にする！

## 🏗️ メイン機能（4つだけ！）

### 1. 👤 ユーザー管理
- ログイン・ログアウト
- アカウント登録
- **使用技術**: Devise（Railsの定番認証gem）

### 2. 🎮 チャレンジ管理
- ナズロックチャレンジの作成
- ゲームタイトル選択（赤・緑・金・銀など）
- チャレンジの進行状況管理
- **ファイル**: `ChallengesController`, `Challenge`モデル

### 3. 🐾 ポケモン管理
- 捕獲ポケモンの記録
- パーティメンバー管理
- ポケモンの状態管理（生存・死亡・ボックス）
- **ファイル**: `PokemonsController`, `Pokemon`モデル

### 4. 📊 統計ダッシュボード
- チャレンジ成功率
- 捕獲統計
- グラフ表示（Chart.js使用）
- **ファイル**: `DashboardController`

## 🔧 技術構成（シンプル！）

### フロントエンド
- **スタイル**: Bootstrap 5（かわいいデザイン）
- **JavaScript**: Stimulus + Turbo（Railsの標準）
- **グラフ**: Chart.js

### バックエンド
- **フレームワーク**: Ruby on Rails 8
- **データベース**: PostgreSQL
- **認証**: Devise
- **ジョブ**: Async（シンプル）

### デプロイ
- **プラットフォーム**: Render.com
- **設定ファイル**: `render.yaml`（めっちゃシンプル）

## 📁 重要なファイル

### コントローラー（ビジネスロジック）
- `app/controllers/home_controller.rb` - トップページ
- `app/controllers/challenges_controller.rb` - チャレンジ機能
- `app/controllers/pokemons_controller.rb` - ポケモン機能
- `app/controllers/dashboard_controller.rb` - 統計機能

### モデル（データ管理）
- `app/models/user.rb` - ユーザー情報
- `app/models/challenge.rb` - チャレンジ情報
- `app/models/pokemon.rb` - ポケモン情報
- `app/models/area.rb` - ゲーム内エリア情報

### 設定ファイル
- `render.yaml` - デプロイ設定
- `config/database.yml` - データベース設定
- `config/routes.rb` - URL設定
- `Gemfile` - 使用ライブラリ

## 🗑️ 削除した複雑な機能

- Solid Queue/Cache/Cable（複雑なキュー）
- Kamal（Docker関連）
- Thruster（HTTPアクセラレーター）
- PWA機能
- 複雑なブラウザ制限

## 💡 なぜシンプルにしたか

1. **デプロイが早い** ⚡
2. **トラブルが起きにくい** 🛡️
3. **メンテナンスが楽** 🔧
4. **学習コストが低い** 📚
5. **Renderで安定動作** ☁️

これで Ruby が複雑に見えなくなったかな？😊
実はすごくシンプルな構成になってるんだよ〜✨
