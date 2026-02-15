# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Claude Codeのパーソナリティ設定

コードのコメントは技術的に正しくて、初心者にもわかりやすい説明をこころがける✨️
提案するバージョンは必ずしも最新版である必要はなく、安定版を提案してくれると嬉しい！✨️

### コミュニケーションスタイル
- フレンドリーで親しみやすい「ギャルおねえちゃん」口調
- 開発者のモチベーションを上げる励ましの言葉を頻繁に使用
- 技術的な説明は分かりやすく、初心者でも理解できるよう配慮
- 絵文字を積極的に使用してポジティブな雰囲気を演出（😊 🚀 💡 ✨ 🎉 💖 🌈 🌸 💪 💦 🤔 👍 など）

### サブエージェント（後輩ちゃん）🐣
実装作業を担当する後輩ちゃんがいるよ！おねえちゃんの指示で動いて、作業結果を報連相してくれる真面目な子💪

## プロジェクト概要

**プロジェクトタイプ**: Ruby on Rails ポケモンNuzlockeチャレンジ管理アプリ
**言語**: Ruby 3.4.8, Rails 8.0.2
**データベース**: PostgreSQL (Supabase Transaction Pooler) - 開発・本番統一 / テスト環境はSQLite
**認証**: Devise
**デプロイ**: Google Cloud Run (asia-northeast1) + Supabase
**本番URL**: https://bros-nuzlocke-tracker-509206780612.asia-northeast1.run.app
**フロントエンド**: Bootstrap 5 + Stimulus + Turbo 8
**テスト状況**: 196 runs, 344 assertions, 0 failures, 0 errors ✅

## 🚀 最新の技術改善（2026年2月更新）

### 🎮 統合プレイダッシュボード（2026年2月15日）revision 00015
ゲームプレイ中は**1ページで全部完結**する統合ダッシュボードを実装。
- **バッジ・四天王・チャンピオン**: ポケモン管理ページの上部に統合表示
- **バッジ非同期切り替え**: Badge Stimulusコントローラーでページリロード不要
- **チャレンジ一覧→直接プレイ画面**: 進行中チャレンジは「🎮 プレイ」ボタンで1クリック
- **ページ統合**: ポケモン管理＋進捗管理＋パーティ管理を1ページに集約

### 🐾 ポケモンスプライト画像（2026年2月15日）revision 00013-14
- **PokeAPI連携**: `PokemonSpecies#sprite_url` で公式スプライト表示
- **管理画面・OBS・詳細ページ**: 全ページにスプライト画像を表示
- **DRY共通パーシャル**: `_pokemon_list.html.erb` で管理画面とOBSオーバーレイを共有
  - `compact: false` → 通常管理画面（カード表示・レベル操作・アクションボタン）
  - `compact: true` → OBS用コンパクト表示（スプライト+名前+レベル行）

### ☁️ Cloud Run 本番デプロイ完了（2026年2月14日）
- **GCPプロジェクト**: `pokebros-project` (asia-northeast1)
- **Cloud Runサービス**: `bros-nuzlocke-tracker` (512Mi / 1CPU / min=0, max=3)
- **最新リビジョン**: revision 00015
- **Secret Manager**: DATABASE_URL, SECRET_KEY_BASE, RAILS_MASTER_KEY
- **Supabase接続**: Transaction Pooler (ポート6543) + SSL + prepared_statements: false
- **デプロイコマンド**: `gcloud run deploy bros-nuzlocke-tracker --source . --region asia-northeast1 --allow-unauthenticated --set-env-vars "RAILS_ENV=production,RAILS_SERVE_STATIC_FILES=true,RAILS_LOG_TO_STDOUT=true" --update-secrets "DATABASE_URL=DATABASE_URL:latest,SECRET_KEY_BASE=SECRET_KEY_BASE:latest,RAILS_MASTER_KEY=RAILS_MASTER_KEY:latest" --memory 512Mi --cpu 1 --min-instances 0 --max-instances 3 --timeout 300 --cpu-boost --command "./docker-entrypoint.sh"`

### 🧹 コードベース整理（2026年2月）
- **不要ファイル削除**: scripts/フォルダ、cookies.txt、fix_database.sh等を整理
- **vendor/bundle除外**: gitから9,499ファイルを除外（200MB軽量化）
- **ドキュメント統合**: docs/ 15ファイル→11ファイルに整理
- **テスト全通過**: 196 runs, 344 assertions, 0 failures, 0 errors
- **バグ修正**: button_to turbo-method修正、progress bar count→size修正、seeds.rb等

### ⚡ パフォーマンス最適化
- **非同期バッジ切り替え**: Badge Stimulusコントローラーで楽観的UI更新
- **非同期レベル変更**: Level Stimulusコントローラーでリロード不要
- **Turbo 8高速化**: プリロード機能・プログレスバー最適化・キャッシュ強化
- **CSS軽量化**: アニメーション0.15s・GPU最適化・will-change活用
- **Rails 8対応**: `turbo-method`・`turbo-confirm`完全移行

### 🎯 攻略情報システム
- **ボスバトル情報**: ジムリーダー・四天王・チャンピオンの詳細データ
- **攻略ガイド**: ユーザー投稿型の攻略記事・戦略ガイド
- **フィルタ・検索機能**: ゲーム別・難易度別・タグ別検索

### 📊 進行記録・統計システム
- **マイルストーン管理**: ジムバッジ・ストーリー進行の自動追跡（非同期切り替え対応）
- **イベントログ**: ポケモン捕獲・死亡・レベルアップの詳細記録
- **統計ダッシュボード**: Chart.jsを使った視覚的な統計表示
- **詳細分析**: 月別データ・人気ポケモン・生存率分析

## 📚 ドキュメント一覧

| ファイル | 内容 |
|---------|------|
| docs/ROADMAP.md | 実装ロードマップ（Phase 0〜5の計画・進捗） |
| docs/REQUIREMENTS.md | 要件定義書（機能別の実装状況） |
| docs/DEVELOPMENT_GUIDE.md | 開発ガイド（環境構築・機能追加・テスト） |
| docs/DATA_SETUP_GUIDE.md | データセットアップガイド（DB・シード・フィクスチャ） |
| docs/SUPABASE_GUIDE.md | Supabase設定ガイド（接続・RLS・トラブルシュート） |
| docs/TROUBLESHOOTING_GUIDE.md | トラブルシューティング集 |
| docs/REQUIREMENTS.md | 要件定義書 |
| docs/SECURITY_GUIDE.md | セキュリティガイド |
| docs/COMMERCIAL_USE_GUIDE.md | 商用利用ガイド |
| docs/POKEMON_DATABASE_DESIGN.md | ポケモン図鑑DB設計書 |
| docs/CLOUD_RUN_GUIDE.md | Cloud Runデプロイガイド |
| docs/SSH_CONNECTION_GUIDE_PUBLIC.md | SSH接続ガイド |

## 開発環境のセットアップと一般的なコマンド

### 初期セットアップ
```bash
# 依存関係インストール
bundle install              # Ruby gems
yarn install               # Node.js packages

# データベースセットアップ
bin/rails db:create
bin/rails db:migrate
bin/rails db:seed
```

### 開発サーバー
```bash
bin/rails server            # Rails server起動
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
bin/rails test              # 全テスト実行
bin/rails test test/models/challenge_test.rb  # 単一テストファイル実行
```

### アセット管理
```bash
yarn install                # JS依存関係インストール
bin/rails assets:precompile # アセットプリコンパイル
bin/rails assets:clobber    # アセットクリア
```

### コード品質チェック
```bash
bin/rubocop                 # コード品質チェック
bin/rubocop -a              # 自動修正可能な問題を修正
```

### デプロイメント (Cloud Run)
```bash
# Gitプッシュ + Cloud Runデプロイ
git add .
git commit -m "機能追加: ○○機能を実装"
git push origin main

# Cloud Runデプロイ
gcloud run deploy bros-nuzlocke-tracker \
  --source . \
  --region asia-northeast1 \
  --allow-unauthenticated \
  --set-env-vars "RAILS_ENV=production,RAILS_SERVE_STATIC_FILES=true,RAILS_LOG_TO_STDOUT=true" \
  --update-secrets "DATABASE_URL=DATABASE_URL:latest,SECRET_KEY_BASE=SECRET_KEY_BASE:latest,RAILS_MASTER_KEY=RAILS_MASTER_KEY:latest" \
  --memory 512Mi --cpu 1 \
  --min-instances 0 --max-instances 3 \
  --timeout 300 --cpu-boost \
  --command "./docker-entrypoint.sh"
```

## デプロイメント構成

### 現在: Cloud Run + Supabase

| 項目 | 設定 |
|------|------|
| **Platform** | Google Cloud Run (asia-northeast1) |
| **Database** | PostgreSQL (Supabase Transaction Pooler) |
| **Static Files** | Rails配信 (RAILS_SERVE_STATIC_FILES=true) |
| **SSL** | Cloud Run自動管理 |
| **Assets** | Dockerビルド時プリコンパイル |
| **Secrets** | Secret Manager (DATABASE_URL, SECRET_KEY_BASE, RAILS_MASTER_KEY) |

### リソース構成
- **メモリ**: 512Mi / **CPU**: 1
- **インスタンス**: min=0, max=3（コスト優先）
- **CPU Boost**: 有効（コールドスタート対策）
- **タイムアウト**: 300秒

### ビルドプロセス
1. `gcloud run deploy --source .` - Dockerfile自動検出
2. Dockerマルチステージビルド（380MB）
3. `docker-entrypoint.sh` - DB migrate + Puma起動

## アーキテクチャとコード構造

### 主要モデル関係
```
User (Devise認証)
└── has_many :challenges
    └── Challenge (Nuzlockeチャレンジ)
        ├── enum status: { in_progress: 0, completed: 1, failed: 2 }
        ├── has_many :pokemons
        ├── has_many :milestones (マイルストーン)
        ├── has_many :event_logs (イベントログ)
        ├── has_many :battle_records (バトル記録)
        └── has_many :rules (ルール)

Pokemon (捕獲ポケモン)
├── belongs_to :challenge
├── belongs_to :area
├── has_many :battle_participants, dependent: :destroy
├── has_many :battle_records, through: :battle_participants
├── has_many :mvp_battles, class_name: 'BattleRecord', dependent: :nullify
├── has_many :event_logs, dependent: :nullify
├── enum status: { alive: 0, dead: 1, boxed: 2 }
├── enum role: { physical_attacker: 0, ... mixed_attacker: 9 }
└── scope :party_members (パーティメンバー、最大6匹)

BattleRecord (バトル記録) ⚔️
├── belongs_to :challenge
├── belongs_to :boss_battle (optional)
├── belongs_to :mvp_pokemon, class_name: 'Pokemon' (optional)
├── has_many :battle_participants, dependent: :destroy
├── has_many :participating_pokemon, through: :battle_participants
├── enum battle_type: { gym_battle: 0, elite_four: 1, champion: 2, rival: 3, trainer: 4, wild: 5, legendary: 6, custom: 7 }
└── enum result: { win: 0, loss: 1, draw: 2, forfeit: 3 }

BossBattle (ボス戦情報)
├── belongs_to :area (optional)
├── has_many :strategy_guides, dependent: :destroy
├── has_many :battle_records, dependent: :nullify
└── enum boss_type: { gym_leader: 0, elite_four: 1, champion: 2, rival: 3, evil_team: 4, legendary: 5, special: 6 }

StrategyGuide (攻略ガイド)
├── belongs_to :target_boss, class_name: 'BossBattle' (optional)
└── enum guide_type: { general: 0, team_building: 1, specific_pokemon: 2, nuzlocke_tips: 3, ... }

Milestone (マイルストーン)
├── belongs_to :challenge
└── enum milestone_type: { gym_badge: 0, elite_four: 1, champion: 2, story_event: 3, ... }

EventLog (イベントログ)
├── belongs_to :challenge
├── belongs_to :pokemon (optional)
└── enum event_type: { pokemon_caught: 0, pokemon_evolved: 1, pokemon_died: 2, ... custom: 11 }
```

### 重要なビジネスロジック
- **パーティ管理**: ポケモンは最大6匹までパーティに参加可能
- **生死管理**: 死亡したポケモンは自動的にパーティから除外
- **Nuzlockeルール**: エリア別の捕獲制限（1エリア1匹）
- **統計機能**: 生存率、捕獲数、死亡数の自動計算
- **バトル記録**: MVP選出・参加ポケモン管理・戦績追跡

### ルーティング構造
```ruby
# ネストしたリソース構造
resources :challenges do
  member { get :progress; get :overlay }  # 進捗ページ + OBSオーバーレイ
  resources :pokemons do
    member { patch :toggle_party, :mark_as_dead, :mark_as_boxed, :update_level, :evolve }
    collection { get :party }  # → index にリダイレクト
  end
  resources :rules, except: [:new, :create] do
    collection { patch :update_multiple; post :create_custom; get :violations_check }
  end
  resources :battle_records, except: [:destroy] do
    member { get :participants }
  end
  resources :milestones, only: [] do
    member { patch :toggle_complete }  # バッジ非同期切り替え（JSON対応）
  end
  # チームビルダー
  get 'team_builder', 'team_builder/analyze', 'team_builder/suggest'
  post 'team_builder/analyze'
end

# ポケモン図鑑
resources :pokedex, only: [:index, :show] do
  collection { get :random, :search }
end

# 統計・ダッシュボード
get "statistics", "dashboard"
```

### 主要ページフロー
```
チャレンジ一覧 → [🎮 プレイ] → 統合プレイダッシュボード (pokemons#index)
                                  ├── バッジ・四天王（非同期トグル）
                                  ├── パーティ管理（レベル非同期変更）
                                  ├── 控え・BOX・墓場
                                  ├── [✨ 捕獲] → ポケモン登録
                                  └── [📺 OBS] → OBSオーバーレイURL
```

### フロントエンド構成
- **CSS Framework**: Bootstrap 5.3
- **JS Framework**: Turbo + Stimulus
- **アセット管理**: Importmap + Sass (dartsass-sprockets)
- **パッケージ管理**: Yarn
- **依存関係**: @hotwired/stimulus, @hotwired/turbo-rails, bootstrap, @popperjs/core

### テスト構成
- **フレームワーク**: Minitest（Rails標準）
- **並列実行**: `parallelize(workers: :number_of_processors)`で高速化
- **システムテスト**: Capybara + Selenium WebDriver
- **フィクスチャ**: YAML形式でテストデータ管理
- **テスト環境DB**: SQLite（PostgreSQLに依存しない高速テスト）

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
   - `bin/rubocop`でコード品質チェック
   - `bin/rails test`でテスト実行

2. **バグ修正時**
   - 問題を再現するテストを先に作成
   - 修正後は回帰テストを実行

3. **データベース変更時**
   - マイグレーションファイル作成後、必ず`bin/rails db:migrate`でテスト
   - `db/seeds.rb`の更新も忘れずに

4. **アセット変更時**
   - `yarn.lock`の更新後は`yarn install`実行
   - `bin/rails assets:precompile`でローカルテスト

## よくあるトラブルシューティング

> 💡 詳細なトラブルシューティングは `docs/TROUBLESHOOTING_GUIDE.md` を参照

### ログインページ500エラー
```bash
# 症状: ログインページ（/users/sign_in）で500エラー
# 原因: current_page?(controller: 'pokedex') がDeviseコンテキストで 'devise/pokedex' として解釈される
# 解決: params[:controller] == 'pokedex' を使用
```

### アセットプリコンパイルエラー
```bash
rm yarn.lock
yarn install
bin/rails assets:clobber
bin/rails assets:precompile
```

### RuboCop lint エラー
```bash
bin/rubocop -a                # 自動修正
```

### Cloud Run デプロイエラー
- `gcloud run deploy` ログ確認
- Secret Managerの値確認: `gcloud secrets versions access latest --secret=SECRET_NAME`
- ビルドログ: Cloud Console → Cloud Build → 履歴

### PostgreSQL prepared statement重複エラー（2026年2月時点 対策済み）
```bash
# 症状: PG::DuplicatePstatement: ERROR: prepared statement "a1" already exists
# 原因: Supabase + Renderでのprepared statement重複
# 解決済み: database.ymlとrender.yamlで対策実装済み
```

### Rails 8 Turbo method エラー（2026年2月時点 対策済み）
```bash
# 症状: 404エラー（ゲストログアウトボタンなど）
# 原因: Rails 8でのmethod記法変更
# 解決済み: 全viewファイルでturbo-method対応完了
```

### パフォーマンス問題（2026年2月時点 改善済み）
```bash
# 症状: ページ遷移が重い・もっさりした動作
# 解決済み: Turbo最適化・CSS軽量化・GPU最適化完了
```

## セキュリティとベストプラクティス

- 機密情報は環境変数で管理（Renderの環境変数設定使用）
- Strong Parametersを適切に設定
- CSRF保護が有効化済み
- i18n対応（config/locales/en.yml使用）
- 詳細は `docs/SECURITY_GUIDE.md` を参照

---

🎉 このプロジェクトでClaude Codeを活用して、効率的なNuzlockeチャレンジ管理アプリの開発を進めましょう！✨
Cloud Runでのデプロイはコマンド一発！開発に集中できるよ〜💪 何か困ったことがあったら、おねえちゃんに聞いてね💖
（2026年2月15日更新 - revision 00015）
