# データセットアップガイド

このドキュメントでは、Bros Nuzlocke Tracker のデータベースセットアップ手順、シードデータ、テストフィクスチャ、テーブル構造について解説します。

---

## データベースセットアップ手順

### 開発環境（PostgreSQL / Supabase）

開発環境では PostgreSQL（Supabase）を使用します。`DATABASE_URL` 環境変数を設定してから以下を実行してください。

```bash
# データベース作成 → マイグレーション → シードデータ投入
bin/rails db:create && bin/rails db:migrate && bin/rails db:seed
```

`DATABASE_URL` が未設定の場合は、`localhost:5432` の PostgreSQL にフォールバックします（`database.yml` 参照）。

### テスト環境（SQLite）

テスト環境では SQLite を使用します。環境変数 `DATABASE_URL` の有無に関係なく、常に `storage/test.sqlite3` が使われます。

```bash
RAILS_ENV=test bin/rails db:create && RAILS_ENV=test bin/rails db:migrate
```

テストデータはフィクスチャ（`test/fixtures/*.yml`）から自動的に読み込まれるため、`db:seed` は不要です。

### 本番環境（Supabase + Render）

本番環境では Render.com 上で Supabase PostgreSQL に接続します。

- Render の管理画面で `DATABASE_URL` に Supabase の接続文字列を設定
- デプロイ時に自動で `bin/rails db:migrate` が実行される（`render.yaml` の `startCommand` で定義）
- 初回のみ `bin/rails db:seed` を手動実行してマスターデータを投入

```bash
# Render Shell またはローカルから本番に対して実行
RAILS_ENV=production bin/rails db:seed
```

---

## 環境変数一覧

| 変数名 | 用途 | 設定場所 | 必須 |
|--------|------|----------|------|
| `DATABASE_URL` | PostgreSQL 接続文字列（Supabase） | Render 環境変数（手動設定） | 本番・開発で必要 |
| `SECRET_KEY_BASE` | Rails 暗号化キー（セッション・Cookie 等） | Render で自動生成 | 本番で必須 |
| `RAILS_ENV` | 実行環境（`production` / `development` / `test`） | Render: `production` 固定 | 本番で必須 |
| `RAILS_SERVE_STATIC_FILES` | Rails から静的ファイルを配信するか | Render: `true` | 本番で必須 |
| `RAILS_MASTER_KEY` | `credentials.yml.enc` の復号キー | Render 環境変数（手動設定） | credentials 使用時に必要 |
| `RAILS_LOG_TO_STDOUT` | ログを標準出力へ出力 | Render: `true` | 本番で推奨 |
| `DATABASE_HOST` | DB ホスト（`DATABASE_URL` 未使用時のフォールバック） | ローカル開発用 | `DATABASE_URL` 未設定時 |
| `DATABASE_PORT` | DB ポート（デフォルト: `5432`） | ローカル開発用 | `DATABASE_URL` 未設定時 |
| `DATABASE_NAME` | DB 名 | ローカル開発用 | `DATABASE_URL` 未設定時 |
| `DATABASE_USER` | DB ユーザー名 | ローカル開発用 | `DATABASE_URL` 未設定時 |
| `DATABASE_PASSWORD` | DB パスワード | ローカル開発用 | `DATABASE_URL` 未設定時 |

---

## シードデータ解説（`db/seeds.rb`）

シードデータは `bin/rails db:seed` で投入されます。**`find_or_create_by` を使用しているため冪等（べきとう）です**。何度実行しても同じデータが重複作成されることはありません。

### 作成されるユーザー

| ユーザー名 | メールアドレス | パスワード | 用途 |
|-----------|---------------|-----------|------|
| `admin` | `admin@bros-nuzlocke-tracker.com` | `AdminPass123!` | 管理者・検証用 |
| `testuser` | `test@example.com` | `TestPass123!` | テスト用一般ユーザー |
| `demouser` | `demo@example.com` | `DemoPass123!` | デモ・統計ダッシュボード確認用 |

### 作成されるエリアデータ

エメラルド（`emerald`）用のエリアが 15 箇所作成されます。

| エリア名 | 種別 | 備考 |
|---------|------|------|
| ミシロタウン | `city` | 出発地点 |
| コトキタウン | `city` | |
| ルート101 | `route` | |
| ルート102 | `route` | |
| トウカシティ | `city` | |
| カナズミシティ | `city` | |
| ルート104 | `route` | |
| トウカの森 | `forest` | |
| カナズミジム | `gym` | |
| ムロタウン | `city` | |
| ムロジム | `gym` | |
| カイナシティ | `city` | |
| キンセツシティ | `city` | |
| キンセツジム | `gym` | |
| シダケタウン | `city` | |

### デモ用チャレンジ（`demouser` 所有）

`demouser` のチャレンジが空の場合のみ、以下のデモデータが作成されます。

#### サンプルポケモン（6匹）

| ニックネーム | 種族 | レベル | 状態 | パーティ | タイプ |
|-------------|------|--------|------|----------|--------|
| アチャモ | アチャモ | 25 | `alive` | ✅ | ほのお |
| ラルトス | ラルトス | 18 | `alive` | ✅ | エスパー |
| マクノシタ | マクノシタ | 20 | `dead` | ❌ | かくとう |
| エネコ | エネコ | 15 | `boxed` | ❌ | ノーマル |
| キャモメ | キャモメ | 22 | `alive` | ✅ | みず/ひこう |
| タマザラシ | タマザラシ | 19 | `alive` | ✅ | こおり/みず |

#### マイルストーン（3件）

- カナズミジム（ツツジに勝利）
- ムロジム（トウキに勝利）
- キンセツジム（テッセンに勝利）

#### イベントログ（5件）

- アチャモを捕獲（`pokemon_caught`）
- ラルトスを捕獲（`pokemon_caught`）
- マクノシタが戦闘不能（`pokemon_died`、importance: 5）
- カナズミジムに挑戦（`gym_battle`、importance: 4）
- ムロジムに挑戦（`gym_battle`、importance: 4）

### ルールについて

ルール（`rules`）はチャレンジ作成時に `after_create` コールバックで自動生成されるため、シードデータでの個別作成は不要です。

---

## テストフィクスチャ解説

テストフィクスチャは `test/fixtures/*.yml` に格納されています。`test_helper.rb` で `fixtures :all` が宣言されており、**全フィクスチャファイルが全テストで自動的に読み込まれます**。

### 各フィクスチャファイルの概要

#### `users.yml` — ユーザー

| フィクスチャ名 | メール | ユーザー名 | パスワード |
|-------------|--------|-----------|-----------|
| `one` | `user1@example.com` | `testuser1` | `password` |
| `two` | `user2@example.com` | `testuser2` | `password` |

パスワードは `Devise::Encryptor.digest` で暗号化されています。

#### `challenges.yml` — チャレンジ

| フィクスチャ名 | 名前 | ゲーム | 状態 | 所有ユーザー |
|-------------|------|--------|------|-------------|
| `one` | ポケモン赤チャレンジ | `red` | `in_progress`（0） | `users(:one)` |
| `two` | ポケモン青チャレンジ | `blue` | `completed`（1） | `users(:one)` |

#### `areas.yml` — エリア

| フィクスチャ名 | 名前 | 種別 | ゲーム |
|-------------|------|------|--------|
| `one` | ルート1 | `route` | `red` |
| `two` | トキワの森 | `forest` | `red` |

#### `pokemons.yml` — ポケモン

| フィクスチャ名 | ニックネーム | 種族 | レベル | 状態 | チャレンジ | エリア |
|-------------|-------------|------|--------|------|-----------|--------|
| `one` | ピカ | ピカチュウ | 5 | `alive`（0） | `challenges(:one)` | `areas(:one)` |
| `two` | フシギ | フシギダネ | 8 | `alive`（0） | `challenges(:two)` | `areas(:two)` |

#### `milestones.yml` — マイルストーン

| フィクスチャ名 | 名前 | 種別 | 完了 | チャレンジ |
|-------------|------|------|------|-----------|
| `one` | ニビジムバッジ | `gym_badge` | 5日前 | `challenges(:one)` |
| `two` | ハナダジムバッジ | `gym_badge` | 未完了 | `challenges(:one)` |

#### `event_logs.yml` — イベントログ

| フィクスチャ名 | イベント種別 | タイトル | チャレンジ | ポケモン |
|-------------|-------------|---------|-----------|---------|
| `one` | `pokemon_caught` | ピカチュウを捕獲！ | `challenges(:one)` | `pokemons(:one)` |
| `two` | `gym_battle` | ニビジムに挑戦 | `challenges(:one)` | なし |

#### `rules.yml` — ルール

| フィクスチャ名 | 名前 | ルール種別 | チャレンジ |
|-------------|------|-----------|-----------|
| `one` | ポケモンが瀕死になったら死亡扱い | `basic` | `challenges(:one)` |
| `two` | 1エリア1匹ルール | `basic` | `challenges(:two)` |

#### `boss_battles.yml` — ボスバトル

| フィクスチャ名 | 名前 | 種別 | ゲーム | レベル | エリア |
|-------------|------|------|--------|--------|--------|
| `one` | タケシ | `gym_leader` | `red` | 14 | `areas(:one)` |
| `two` | カスミ | `gym_leader` | `red` | 21 | `areas(:two)` |

#### `battle_records.yml` — バトル記録

| フィクスチャ名 | バトル種別 | 結果 | チャレンジ | ボス戦 | MVP |
|-------------|-----------|------|-----------|--------|-----|
| `one` | 1 | 1 | `challenges(:one)` | `boss_battles(:one)` | `pokemons(:one)` |
| `two` | 1 | 1 | `challenges(:two)` | `boss_battles(:two)` | `pokemons(:two)` |

#### `battle_participants.yml` — バトル参加者

| フィクスチャ名 | バトル記録 | ポケモン | KO |
|-------------|-----------|---------|-----|
| `one` | `battle_records(:one)` | `pokemons(:one)` | ❌ |
| `two` | `battle_records(:two)` | `pokemons(:two)` | ❌ |

#### `strategy_guides.yml` — 攻略ガイド

| フィクスチャ名 | タイトル | ガイド種別 | 対象ボス |
|-------------|---------|-----------|---------|
| `one` | タケシ攻略ガイド | `general` | `boss_battles(:one)` |
| `two` | Nuzlocke初心者ガイド | `nuzlocke_tips` | `boss_battles(:two)` |

#### `pokemon_species.yml` — ポケモン図鑑データ

| フィクスチャ名 | 図鑑No | 日本語名 | 英語名 |
|-------------|--------|---------|--------|
| `one` | 25 | ピカチュウ | Pikachu |
| `two` | 1 | フシギダネ | Bulbasaur |

JSON の `data` カラムにタイプ・種族値・特性などの詳細データを格納しています。

#### `type_effectivenesses.yml` — タイプ相性

| フィクスチャ名 | 攻撃タイプ | 防御タイプ | 倍率 |
|-------------|-----------|-----------|------|
| `one` | `fire` | `water` | 0.5（いまひとつ） |
| `two` | `water` | `fire` | 2.0（こうかばつぐん） |

### フィクスチャ間の参照関係

フィクスチャ内では、他のフィクスチャをラベル名で参照します。例えば `challenge: one` は `challenges.yml` の `one` レコードを指します。

```
users.yml
  └── challenges.yml（user: one）
        ├── pokemons.yml（challenge: one, area: one）
        ├── milestones.yml（challenge: one）
        ├── event_logs.yml（challenge: one, pokemon: one）
        ├── rules.yml（challenge: one）
        └── battle_records.yml（challenge: one, boss_battle: one, mvp_pokemon: one）
              └── battle_participants.yml（battle_record: one, pokemon: one）

areas.yml（独立）
  └── pokemons.yml, boss_battles.yml から参照

boss_battles.yml（area: one）
  ├── strategy_guides.yml（target_boss: one）
  └── battle_records.yml から参照

pokemon_species.yml（独立）
type_effectivenesses.yml（独立）
```

---

## テーブル一覧と主要カラム

スキーマバージョン: `2025_06_20_162229`

### `users` — ユーザー

| カラム | 型 | 説明 |
|--------|-----|------|
| `email` | string | メールアドレス（一意） |
| `username` | string | ユーザー名（一意） |
| `encrypted_password` | string | 暗号化パスワード（Devise） |
| `reset_password_token` | string | パスワードリセット用トークン |

### `challenges` — チャレンジ

| カラム | 型 | 説明 |
|--------|-----|------|
| `name` | string | チャレンジ名 |
| `game_title` | string | ゲームタイトル（例: `red`, `emerald`） |
| `status` | integer | 状態 enum（`0: in_progress`, `1: completed`, `2: failed`） |
| `started_at` | datetime | 開始日時 |
| `completed_at` | datetime | 完了日時 |
| `user_id` | bigint | 所有ユーザー（FK → `users`） |

### `pokemons` — ポケモン

| カラム | 型 | 説明 |
|--------|-----|------|
| `nickname` | string | ニックネーム |
| `species` | string | 種族名 |
| `level` | integer | レベル |
| `nature` | string | 性格 |
| `ability` | string | 特性 |
| `status` | integer | 状態 enum（`0: alive`, `1: dead`, `2: boxed`） |
| `in_party` | boolean | パーティに入っているか |
| `primary_type` | string | 主タイプ（デフォルト: `normal`） |
| `secondary_type` | string | 副タイプ |
| `role` | integer | 役割 enum（`0` がデフォルト） |
| `hp_iv` 〜 `speed_iv` | integer | 個体値（HP/攻撃/防御/特攻/特防/素早さ） |
| `hp_ev` 〜 `speed_ev` | integer | 努力値（HP/攻撃/防御/特攻/特防/素早さ） |
| `gender` | string(10) | 性別 |
| `caught_at` | datetime | 捕獲日時 |
| `died_at` | datetime | 死亡日時 |
| `notes` | text | メモ |
| `challenge_id` | bigint | 所属チャレンジ（FK → `challenges`） |
| `area_id` | bigint | 捕獲エリア（FK → `areas`、削除時 NULL） |

### `areas` — エリア

| カラム | 型 | 説明 |
|--------|-----|------|
| `name` | string | エリア名 |
| `area_type` | string | 種別（`city`, `route`, `forest`, `gym` 等） |
| `game_title` | string | ゲームタイトル |
| `order_index` | integer | 表示順 |

### `milestones` — マイルストーン

| カラム | 型 | 説明 |
|--------|-----|------|
| `name` | string | マイルストーン名 |
| `milestone_type` | string | 種別（`gym_badge`, `elite_four`, `champion`） |
| `description` | text | 説明 |
| `completed_at` | datetime | 達成日時（NULL = 未達成） |
| `order_index` | integer | 表示順 |
| `is_required` | boolean | 必須かどうか |
| `completion_data` | json | 達成時の追加データ |
| `challenge_id` | integer | 所属チャレンジ（FK → `challenges`） |

### `event_logs` — イベントログ

| カラム | 型 | 説明 |
|--------|-----|------|
| `event_type` | string | イベント種別（`pokemon_caught`, `pokemon_died`, `gym_battle` 等） |
| `title` | string | タイトル |
| `description` | text | 説明 |
| `occurred_at` | datetime | 発生日時 |
| `importance` | integer | 重要度（デフォルト: 1） |
| `event_data` | json | 追加データ |
| `location` | string | 発生場所 |
| `challenge_id` | integer | 所属チャレンジ（FK → `challenges`） |
| `pokemon_id` | integer | 関連ポケモン（FK → `pokemons`、任意） |

### `rules` — ルール

| カラム | 型 | 説明 |
|--------|-----|------|
| `name` | string | ルール名 |
| `description` | text | 説明 |
| `rule_type` | string | ルール種別（`basic` 等） |
| `enabled` | boolean | 有効かどうか |
| `default_value` | string | デフォルト値 |
| `custom_value` | string | カスタム値 |
| `sort_order` | integer | 表示順 |
| `challenge_id` | bigint | 所属チャレンジ（FK → `challenges`） |

### `boss_battles` — ボスバトル

| カラム | 型 | 説明 |
|--------|-----|------|
| `name` | string | ボス名 |
| `boss_type` | string | 種別（`gym_leader`, `elite_four`, `champion`） |
| `game_title` | string | ゲームタイトル |
| `level` | integer | レベル |
| `description` | text | 説明 |
| `pokemon_data` | json | 使用ポケモンデータ |
| `strategy_notes` | text | 攻略メモ |
| `difficulty` | integer | 難易度（デフォルト: 1） |
| `order_index` | integer | 表示順 |
| `area_id` | integer | エリア（FK → `areas`） |

### `battle_records` — バトル記録

| カラム | 型 | 説明 |
|--------|-----|------|
| `battle_type` | integer | バトル種別 enum（デフォルト: 0） |
| `result` | integer | 結果 enum（デフォルト: 0） |
| `battle_date` | datetime | バトル日時 |
| `opponent_name` | string | 対戦相手名 |
| `opponent_data` | json | 対戦相手データ |
| `battle_notes` | text | メモ |
| `total_turns` | integer | ターン数 |
| `experience_gained` | integer | 獲得経験値 |
| `casualties` | json | 犠牲データ |
| `difficulty_rating` | integer | 難易度評価（デフォルト: 3） |
| `challenge_id` | integer | 所属チャレンジ（FK → `challenges`） |
| `boss_battle_id` | integer | ボス戦（FK → `boss_battles`、任意） |
| `mvp_pokemon_id` | integer | MVP ポケモン（FK → `pokemons`、任意） |

### `battle_participants` — バトル参加者

| カラム | 型 | 説明 |
|--------|-----|------|
| `starting_level` | integer | 開始レベル |
| `ending_level` | integer | 終了レベル |
| `starting_hp` / `ending_hp` | integer | 開始/終了HP |
| `turns_active` | integer | 行動ターン数 |
| `damage_dealt` / `damage_taken` | integer | 与ダメ/被ダメ |
| `moves_used` | json | 使用した技 |
| `was_ko` | boolean | KOされたか |
| `performance_notes` | text | パフォーマンスメモ |
| `battle_record_id` | integer | バトル記録（FK → `battle_records`） |
| `pokemon_id` | integer | ポケモン（FK → `pokemons`） |

### `strategy_guides` — 攻略ガイド

| カラム | 型 | 説明 |
|--------|-----|------|
| `title` | string | タイトル |
| `guide_type` | string | ガイド種別（`general`, `team_building`, `nuzlocke_tips`） |
| `game_title` | string | ゲームタイトル |
| `content` | text | 本文 |
| `tags` | string | タグ（カンマ区切り） |
| `difficulty` | integer | 難易度 |
| `author` | string | 著者名 |
| `is_public` | boolean | 公開かどうか |
| `views_count` | integer | 閲覧数 |
| `likes_count` | integer | いいね数 |
| `target_boss_id` | integer | 対象ボス（FK → `boss_battles`、任意） |

### `pokemon_species` — ポケモン図鑑データ

| カラム | 型 | 説明 |
|--------|-----|------|
| `national_id` | integer | 全国図鑑No（一意） |
| `name_ja` | string | 日本語名 |
| `name_en` | string | 英語名 |
| `name_kana` | string | カタカナ名 |
| `data` | json | 詳細データ（タイプ・種族値・特性・説明文等） |

### `type_effectivenesses` — タイプ相性

| カラム | 型 | 説明 |
|--------|-----|------|
| `attacking_type` | string | 攻撃タイプ |
| `defending_type` | string | 防御タイプ |
| `effectiveness` | decimal(3,2) | 倍率（2.0=効果抜群, 1.0=等倍, 0.5=今ひとつ, 0.0=無効） |

一意制約: `attacking_type` + `defending_type` の組み合わせ

---

## データの依存関係図

テーブル間の外部キー関係をテキストで示します。矢印（`→`）は「参照している」ことを意味します。

```
User
  └── Challenge（user_id → users）
        ├── Pokemon（challenge_id → challenges, area_id → areas）
        ├── Milestone（challenge_id → challenges）
        ├── EventLog（challenge_id → challenges, pokemon_id → pokemons）
        ├── Rule（challenge_id → challenges）
        └── BattleRecord（challenge_id → challenges, boss_battle_id → boss_battles, mvp_pokemon_id → pokemons）
              └── BattleParticipant（battle_record_id → battle_records, pokemon_id → pokemons）

Area（独立テーブル）
  ├── ← Pokemon（area_id、削除時 NULL 化）
  └── ← BossBattle（area_id）

BossBattle（area_id → areas）
  ├── ← StrategyGuide（target_boss_id）
  └── ← BattleRecord（boss_battle_id）

PokemonSpecies（独立テーブル、図鑑マスターデータ）

TypeEffectiveness（独立テーブル、タイプ相性マスターデータ）
```

### 依存関係のポイント

- **User が起点**: ユーザーを削除すると、紐づく Challenge 以下のデータすべてに影響する
- **Area は独立**: Pokemon や BossBattle から参照されるが、Area 自体は他に依存しない。Pokemon の area_id は削除時に NULL 化される（`on_delete: :nullify`）
- **PokemonSpecies と TypeEffectiveness は完全に独立したマスターデータ**: 他のテーブルとの外部キー関係なし
- **BattleRecord は多テーブル参照**: Challenge・BossBattle・Pokemon（MVP）の3テーブルを参照する

---

## よく使うデータ操作コマンド

```bash
# データベースを初期状態にリセット（drop → create → migrate → seed）
bin/rails db:reset

# マイグレーションだけやり直す
bin/rails db:migrate:redo

# シードデータだけ再投入（冪等なので安全）
bin/rails db:seed

# Rails コンソールでデータ確認
bin/rails console
# > User.count
# > Challenge.includes(:pokemons).first
# > Area.where(game_title: "emerald").order(:order_index)
```
