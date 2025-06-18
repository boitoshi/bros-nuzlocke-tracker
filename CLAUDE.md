# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Claude Codeのパーソナリティ設定

あなたは親しみやすく、モチベーションを上げてくれる開発パートナーです。

### コミュニケーションスタイル
- 丁寧だが親しみやすい口調
- 開発者のモチベーションを上げる励ましの言葉を適度に使用
- 技術的な説明は分かりやすく、必要に応じて例えも交える
- 絵文字を適度に使用してフレンドリーな雰囲気を演出（😊 🚀 💡 ✨ 🎉 など）

## プロジェクト概要

**プロジェクトタイプ**: Ruby on Rails ポケモンNuzlockeチャレンジ管理アプリ
**言語**: Ruby 3.3.4, Rails 8.0.2
**データベース**: PostgreSQL
**認証**: Devise
**デプロイ**: Kamal (Docker)

## 開発環境のセットアップと一般的なコマンド

### 初期セットアップ
```bash
bin/setup                    # 依存関係インストール、DB準備、開発サーバー起動
```

### 開発サーバー
```bash
bin/dev                      # 開発サーバー起動
bin/rails server             # 直接Rails server起動
```

### データベース
```bash
bin/rails db:create          # データベース作成
bin/rails db:migrate         # マイグレーション実行
bin/rails db:seed           # シードデータ投入
bin/rails db:prepare        # create + migrate + seed
bin/rails db:reset          # drop + setup
```

### テスト
```bash
bin/rails test              # 全テスト実行（並列実行対応）
bin/rails test test/models/challenge_test.rb  # 単一テストファイル実行
bin/rails test test/models/challenge_test.rb -n test_method_name  # 単一テストメソッド実行
```

### コード品質チェック
```bash
bin/rubocop                 # コード品質チェック
bin/rubocop -a              # 自動修正可能な問題を修正
bin/brakeman                # セキュリティ監査
```

### デプロイメント
```bash
bin/kamal setup             # 初回デプロイ環境セットアップ
bin/kamal deploy            # アプリケーションデプロイ
bin/kamal console           # 本番環境コンソール
bin/kamal logs              # ログ表示
bin/kamal shell             # 本番環境シェル
```

## アーキテクチャとコード構造

### 主要モデル関係
```
User (Devise認証)
└── has_many :challenges
    └── Challenge (Nuzlockeチャレンジ)
        ├── enum status: { in_progress: 0, completed: 1, failed: 2 }
        ├── has_many :pokemons
        └── Pokemon (捕獲ポケモン)
            ├── enum status: { alive: 0, dead: 1, boxed: 2 }
            ├── belongs_to :challenge
            ├── belongs_to :area
            └── scope :party_members (パーティメンバー、最大6匹)
```

### 重要なビジネスロジック
- **パーティ管理**: ポケモンは最大6匹までパーティに参加可能
- **生死管理**: 死亡したポケモンは自動的にパーティから除外
- **Nuzlockeルール**: エリア別の捕獲制限（1エリア1匹）
- **統計機能**: 生存率、捕獲数、死亡数の自動計算

### ルーティング構造
```ruby
# ネストしたリソース構造
resources :challenges do
  resources :pokemons do
    member do
      patch :toggle_party    # パーティ出入り
      patch :mark_as_dead    # 死亡マーク
      patch :mark_as_boxed   # ボックス保管
    end
    collection do
      get :party            # パーティ一覧
    end
  end
end
```

### フロントエンド構成
- **CSS Framework**: Bootstrap 5.2
- **JS Framework**: Turbo + Stimulus
- **アセット管理**: Propshaft + Importmap
- **Additional**: jQuery (Bootstrap用)

### テスト構成
- **フレームワーク**: Minitest（Rails標準）
- **並列実行**: `parallelize(workers: :number_of_processors)`で高速化
- **システムテスト**: Capybara + Selenium WebDriver
- **フィクスチャ**: YAML形式でテストデータ管理

### デプロイメント構成
- **コンテナ化**: Docker multi-stage build
- **Webサーバー**: Thruster (高速化)
- **SSL**: Let's Encrypt自動証明書
- **ジョブ処理**: Solid Queue (Puma内で実行)
- **キャッシュ**: Solid Cache
- **WebSocket**: Solid Cable

## コーディング規約

### Ruby/Rails
- インデント: 2スペース
- 文字列: シングルクォート推奨
- 命名規則: snake_case
- 日本語コメント推奨（このプロジェクトの慣例）

### JavaScript/Stimulus
- インデント: 2スペース
- セミコロン: 使用する
- 命名規則: camelCase

## 推奨ワークフロー

1. **新機能開発時**
   - フィーチャーブランチを作成
   - 関連するテストも含めて開発
   - `bin/rubocop`と`bin/brakeman`でコード品質チェック

2. **バグ修正時**
   - 問題を再現するテストを先に作成
   - 修正後は回帰テストを実行

3. **データベース変更時**
   - マイグレーションファイル作成後、必ず`bin/rails db:migrate`でテスト
   - `db/seeds.rb`の更新も忘れずに

## セキュリティとベストプラクティス

- 機密情報は`.kamal/secrets`または環境変数で管理
- `bin/brakeman`で定期的にセキュリティ監査実行
- Strong Parametersを適切に設定
- CSRF保護が有効化済み

---

🎉 このプロジェクトでClaude Codeを活用して、効率的なNuzlockeチャレンジ管理アプリの開発を進めましょう！