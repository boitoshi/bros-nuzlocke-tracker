# 🛠️ Bros Nuzlocke Tracker 開発ガイド

このドキュメントでは、各機能の修正・改修・新機能追加の詳細な手順を説明します。
Rails初心者でも理解できるよう、具体例とともに解説しています。

## 📚 目次

1. [開発環境の準備](#開発環境の準備)
2. [プロジェクト構成の理解](#プロジェクト構成の理解)
3. [機能別開発ガイド](#機能別開発ガイド)
4. [データベース操作](#データベース操作)
5. [フロントエンド修正](#フロントエンド修正)
6. [テスト作成](#テスト作成)
7. [デプロイ手順](#デプロイ手順)

---

## 🚀 開発環境の準備

### Step 1: 初回セットアップ
```bash
# 1. プロジェクトクローン
git clone <repository-url>
cd bros-nuzlocke-tracker

# 2. 依存関係インストール
bundle install
yarn install

# 3. データベース準備
bin/rails db:create
bin/rails db:migrate
bin/rails db:seed

# 4. 開発サーバー起動
bin/rails server
# => http://localhost:3000 でアクセス確認
```

### Step 2: 開発用コマンド
```bash
# 🖥️ よく使うコマンド
bin/rails server              # サーバー起動
bin/rails console             # Railsコンソール（データ確認・操作）
bin/rails test               # テスト実行
bin/rails db:migrate         # マイグレーション実行

# 🔧 便利なエイリアス設定（.bashrc/.zshrcに追加）
alias rs="bin/rails server"
alias rc="bin/rails console"
alias rt="bin/rails test"
alias rdm="bin/rails db:migrate"
```

---

## 🏗️ プロジェクト構成の理解

### MVC アーキテクチャ
```
app/
├── controllers/     # ビジネスロジック（リクエスト処理）
├── models/          # データモデル（データベース操作）
├── views/           # 画面表示（HTML生成）
└── assets/          # CSS/JS（見た目・動作）
```

### 主要ファイル一覧
```
重要度: ⭐⭐⭐（よく修正） ⭐⭐（たまに修正） ⭐（設定ファイル）

⭐⭐⭐ app/controllers/
├── challenges_controller.rb    # チャレンジ機能
├── pokemons_controller.rb      # ポケモン機能
├── dashboard_controller.rb     # 統計機能
└── home_controller.rb          # トップページ

⭐⭐⭐ app/models/
├── challenge.rb                # チャレンジデータ
├── pokemon.rb                  # ポケモンデータ
├── user.rb                     # ユーザーデータ
└── area.rb                     # エリアデータ

⭐⭐⭐ app/views/
├── challenges/                 # チャレンジ画面
├── pokemons/                   # ポケモン画面
├── dashboard/                  # 統計画面
└── layouts/application.html.erb # 共通レイアウト

⭐⭐ config/
├── routes.rb                   # URL設定
└── database.yml                # DB設定

⭐ その他
├── render.yaml                 # デプロイ設定
└── Gemfile                     # ライブラリ管理
```

---

## 🎯 機能別開発ガイド

### 1. 🎮 新しいゲームタイトル追加

**例: 「ダイヤモンド・パール」を追加したい**

#### Step 1: モデルに定数追加
```ruby
# app/models/challenge.rb
class Challenge < ApplicationRecord
  # 既存のゲームタイトル
  enum game_title: {
    red: 0,
    blue: 1,
    yellow: 2,
    gold: 3,
    silver: 4,
    crystal: 5,
    ruby: 6,
    sapphire: 7,
    emerald: 8,
    # ここに追加 ⬇️
    diamond: 9,
    pearl: 10
  }
end
```

#### Step 2: エリアデータ追加
```ruby
# app/models/area.rb
def self.create_areas_for_game(game_title)
  case game_title.to_s
  when "diamond", "pearl"
    areas = [
      { name: "201番道路", area_type: :route, order_index: 1 },
      { name: "サンドジム", area_type: :gym, order_index: 2 },
      { name: "202番道路", area_type: :route, order_index: 3 },
      # 必要なエリアを追加...
    ]
    areas.each do |area_data|
      create!(area_data.merge(game_title: game_title))
    end
  end
end
```

#### Step 3: 選択肢をビューに追加
```erb
<!-- app/views/challenges/_form.html.erb -->
<%= form.select :game_title, 
    options_for_select([
      ['ポケットモンスター赤', 'red'],
      ['ポケットモンスター青', 'blue'],
      # 追加 ⬇️
      ['ポケットモンスターダイヤモンド', 'diamond'],
      ['ポケットモンスターパール', 'pearl']
    ]), 
    { prompt: 'ゲームを選択してください' }, 
    { class: 'form-select' } %>
```

#### Step 4: テスト追加
```ruby
# test/models/challenge_test.rb
test "diamond game title should be valid" do
  challenge = Challenge.new(
    name: "ダイヤモンド チャレンジ",
    game_title: "diamond",
    user: users(:one)
  )
  assert challenge.valid?
end
```

---

### 2. 🐾 ポケモン新機能追加

**例: ポケモンの「性格」フィールドを追加したい**

#### Step 1: マイグレーション作成
```bash
# ターミナルで実行
bin/rails generate migration AddNatureToPokemon nature:string
```

#### Step 2: マイグレーション実行
```bash
bin/rails db:migrate
```

#### Step 3: モデル更新
```ruby
# app/models/pokemon.rb
class Pokemon < ApplicationRecord
  # バリデーション追加
  validates :nature, presence: true, inclusion: { 
    in: %w[がんばりや さみしがり かたい いじっぱり やんちゃ] 
  }
  
  # 新しいスコープ追加
  scope :with_nature, ->(nature) { where(nature: nature) }
end
```

#### Step 4: フォーム更新
```erb
<!-- app/views/pokemons/_form.html.erb -->
<div class="mb-3">
  <%= form.label :nature, "性格", class: "form-label" %>
  <%= form.select :nature, 
      options_for_select([
        ['がんばりや', 'がんばりや'],
        ['さみしがり', 'さみしがり'],
        ['かたい', 'かたい']
        # 他の性格も追加
      ]), 
      { prompt: '性格を選択' }, 
      { class: 'form-select' } %>
</div>
```

#### Step 5: 表示ビュー更新
```erb
<!-- app/views/pokemons/show.html.erb -->
<div class="card-body">
  <p><strong>性格:</strong> <%= @pokemon.nature %></p>
  <!-- その他の表示項目 -->
</div>
```

#### Step 6: Strong Parameters更新
```ruby
# app/controllers/pokemons_controller.rb
private

def pokemon_params
  params.require(:pokemon).permit(
    :nickname, :species, :level, :area_id, :caught_at,
    :nature # 追加
  )
end
```

---

### 3. 📊 統計機能追加

**例: 「最も人気な性格」の統計を追加したい**

#### Step 1: モデルにスコープ追加
```ruby
# app/models/pokemon.rb
class Pokemon < ApplicationRecord
  # 性格別統計メソッド追加
  scope :nature_stats, -> { group(:nature).count }
  
  # クラスメソッドで統計取得
  def self.popular_natures(limit = 5)
    nature_stats.order(count: :desc).limit(limit)
  end
end
```

#### Step 2: コントローラー更新
```ruby
# app/controllers/dashboard_controller.rb
def index
  # 既存の統計データ
  @challenge_stats = current_user.challenges.total_stats
  @pokemon_stats = Pokemon.joins(:challenge)
                          .where(challenges: { user: current_user })
                          .total_stats
  
  # 新しい統計データ追加
  @nature_popularity = Pokemon.joins(:challenge)
                              .where(challenges: { user: current_user })
                              .popular_natures(10)
end
```

#### Step 3: ビューに表示追加
```erb
<!-- app/views/dashboard/index.html.erb -->
<div class="row mb-4">
  <div class="col-md-6">
    <div class="card">
      <div class="card-header">
        <h5>人気の性格 TOP 5</h5>
      </div>
      <div class="card-body">
        <% @nature_popularity.each_with_index do |(nature, count), index| %>
          <div class="d-flex justify-content-between">
            <span><%= index + 1 %>. <%= nature %></span>
            <span class="badge bg-primary"><%= count %>匹</span>
          </div>
        <% end %>
      </div>
    </div>
  </div>
</div>
```

---

## 🗄️ データベース操作

### マイグレーション作成パターン

```bash
# 新しいテーブル作成
bin/rails generate model NewModel name:string description:text

# カラム追加
bin/rails generate migration AddColumnToTable column_name:data_type

# カラム削除
bin/rails generate migration RemoveColumnFromTable column_name:data_type

# インデックス追加
bin/rails generate migration AddIndexToTable column_name:index
```

### よく使うデータタイプ
```ruby
:string      # 短いテキスト（255文字まで）
:text        # 長いテキスト
:integer     # 整数
:decimal     # 小数点
:boolean     # true/false
:datetime    # 日時
:date        # 日付
:time        # 時刻
:references  # 外部キー
```

### マイグレーション例
```ruby
# db/migrate/xxx_add_features_to_pokemon.rb
class AddFeaturesToPokemon < ActiveRecord::Migration[8.0]
  def change
    add_column :pokemons, :nature, :string
    add_column :pokemons, :ability, :string
    add_column :pokemons, :experience_points, :integer, default: 0
    
    add_index :pokemons, :nature
    add_index :pokemons, [:challenge_id, :status]
  end
end
```

---

## 🎨 フロントエンド修正

### Bootstrap クラス活用

```erb
<!-- よく使うBootstrapクラス -->

<!-- レイアウト -->
<div class="container">           <!-- コンテナ -->
<div class="row">                 <!-- 行 -->
<div class="col-md-6">            <!-- 列（中画面で6/12幅） -->

<!-- ボタン -->
<%= link_to "編集", edit_path, class: "btn btn-primary" %>
<%= link_to "削除", destroy_path, class: "btn btn-danger" %>

<!-- カード -->
<div class="card">
  <div class="card-header">タイトル</div>
  <div class="card-body">内容</div>
</div>

<!-- フォーム -->
<div class="mb-3">                <!-- マージン -->
  <%= form.label :name, class: "form-label" %>
  <%= form.text_field :name, class: "form-control" %>
</div>

<!-- アラート -->
<div class="alert alert-success">成功メッセージ</div>
<div class="alert alert-danger">エラーメッセージ</div>
```

### カスタムCSS追加

```scss
// app/assets/stylesheets/application.scss
// カスタムスタイル追加例

.pokemon-card {
  transition: transform 0.3s ease;
  
  &:hover {
    transform: translateY(-5px);
    box-shadow: 0 4px 15px rgba(0,0,0,0.2);
  }
}

.nature-badge {
  background: linear-gradient(45deg, #667eea, #764ba2);
  color: white;
  padding: 4px 8px;
  border-radius: 12px;
  font-size: 0.8rem;
}

// ゲーム別カラー
.game-red { border-left: 4px solid #ff6b6b; }
.game-blue { border-left: 4px solid #4ecdc4; }
.game-gold { border-left: 4px solid #ffd93d; }
```

---

## 🧪 テスト作成

### モデルテスト例

```ruby
# test/models/pokemon_test.rb
require "test_helper"

class PokemonTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @challenge = challenges(:one)
    @pokemon = Pokemon.new(
      nickname: "ピカちゃん",
      species: "ピカチュウ",
      level: 5,
      nature: "がんばりや",
      challenge: @challenge
    )
  end

  test "valid pokemon should be saved" do
    assert @pokemon.valid?
    assert @pokemon.save
  end

  test "nickname should be present" do
    @pokemon.nickname = ""
    assert_not @pokemon.valid?
    assert_includes @pokemon.errors[:nickname], "can't be blank"
  end

  test "level should be positive" do
    @pokemon.level = -1
    assert_not @pokemon.valid?
  end

  test "nature stats should return correct data" do
    # テストデータでの性格統計確認
    stats = Pokemon.nature_stats
    assert_kind_of Hash, stats
  end
end
```

### コントローラーテスト例

```ruby
# test/controllers/pokemons_controller_test.rb
require "test_helper"

class PokemonsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:one)
    @challenge = challenges(:one)
    @pokemon = pokemons(:one)
    sign_in @user
  end

  test "should get index" do
    get challenge_pokemons_url(@challenge)
    assert_response :success
    assert_select "h1", /ポケモン一覧/
  end

  test "should create pokemon with valid data" do
    assert_difference("Pokemon.count") do
      post challenge_pokemons_url(@challenge), params: {
        pokemon: {
          nickname: "テストポケモン",
          species: "フシギダネ",
          level: 5,
          nature: "がんばりや",
          area_id: areas(:one).id
        }
      }
    end
    assert_redirected_to challenge_pokemon_url(@challenge, Pokemon.last)
  end

  test "should not create pokemon with invalid data" do
    assert_no_difference("Pokemon.count") do
      post challenge_pokemons_url(@challenge), params: {
        pokemon: {
          nickname: "",  # 空の名前（バリデーションエラー）
          species: "フシギダネ",
          level: 5
        }
      }
    end
    assert_response :unprocessable_entity
  end
end
```

### フィクスチャ作成

```yaml
# test/fixtures/pokemons.yml
one:
  nickname: "テストピカチュウ"
  species: "ピカチュウ"
  level: 10
  nature: "がんばりや"
  status: "alive"
  challenge: one
  area: one
  caught_at: <%= 1.day.ago %>

two:
  nickname: "テストフシギダネ"
  species: "フシギダネ"
  level: 5
  nature: "おくびょう"
  status: "alive"
  challenge: one
  area: one
  caught_at: <%= 2.days.ago %>
```

---

## 🚀 デプロイ手順

### Step 1: ローカルでテスト
```bash
# 1. テスト実行
bin/rails test
# ✅ すべてのテストが通ることを確認

# 2. アセットプリコンパイル確認
RAILS_ENV=production bin/rails assets:precompile
# ✅ エラーが出ないことを確認

# 3. マイグレーション確認
bin/rails db:migrate:status
# ✅ pending状態のマイグレーションがないことを確認
```

### Step 2: コミット&プッシュ
```bash
# 1. 変更内容確認
git status
git diff

# 2. コミット
git add .
git commit -m "feat: ポケモンの性格機能を追加

- Pokemonモデルにnatureカラム追加
- フォームに性格選択フィールド追加
- 統計ページに人気性格ランキング追加
- 関連テスト追加"

# 3. プッシュ
git push origin main
```

### Step 3: デプロイ監視
```bash
# Renderダッシュボードで確認項目:
# 1. Build Status: ✅ Build succeeded
# 2. Deploy Status: ✅ Deploy succeeded  
# 3. Service Status: ✅ Live
# 4. Logs: エラーが出ていないか確認
```

### Step 4: 本番動作確認
```bash
# 本番環境で確認:
# 1. サイトにアクセスできるか
# 2. 新機能が正常に動作するか
# 3. 既存機能に影響がないか
# 4. データベースマイグレーションが完了しているか
```

---

## 🚨 緊急時対応

### ロールバック（前のバージョンに戻す）
```bash
# Renderダッシュボードで:
# 1. "Manual Deploy" → "Deploy latest commit"
# 2. または前のコミットを指定してデプロイ

# ローカルでのロールバック:
git log --oneline               # コミット履歴確認
git reset --hard <commit-hash>  # 指定コミットに戻す
git push --force origin main    # 強制プッシュ（注意！）
```

### データベースロールバック
```bash
# マイグレーションを1つ戻す
bin/rails db:rollback

# 指定ステップ数戻す
bin/rails db:rollback STEP=3

# 特定バージョンに戻す
bin/rails db:migrate:down VERSION=20240619000000
```

---

## 📋 開発チェックリスト

### 新機能開発時
- [ ] ローカル環境でテスト実行（`bin/rails test`）
- [ ] 新しいテストケース追加
- [ ] コードレビュー（自分で一度見直し）
- [ ] ドキュメント更新（必要に応じて）
- [ ] アセットプリコンパイル確認
- [ ] git commit メッセージを分かりやすく
- [ ] 本番デプロイ後の動作確認

### バグ修正時
- [ ] 問題の再現手順を確認
- [ ] 修正箇所の特定
- [ ] テストケースで修正を検証
- [ ] 関連機能への影響確認
- [ ] 修正内容を commit message に明記

---

## 💡 よくある質問（FAQ）

### Q: 新しいページを追加したい
```bash
# 1. コントローラー生成
bin/rails generate controller Pages about contact

# 2. ルート追加（config/routes.rb）
get 'about', to: 'pages#about'
get 'contact', to: 'pages#contact'

# 3. ビューファイル作成
# app/views/pages/about.html.erb
# app/views/pages/contact.html.erb
```

### Q: フォームのバリデーションを追加したい
```ruby
# app/models/pokemon.rb
validates :nickname, presence: true, length: { maximum: 50 }
validates :level, presence: true, 
                  numericality: { greater_than: 0, less_than_or_equal_to: 100 }
validates :species, presence: true, inclusion: { 
  in: %w[ピカチュウ フシギダネ ヒトカゲ ゼニガメ] 
}
```

### Q: 画像アップロード機能を追加したい
```ruby
# 1. Active Storage セットアップ
bin/rails active_storage:install
bin/rails db:migrate

# 2. モデルに関連付け追加
class Pokemon < ApplicationRecord
  has_one_attached :image
end

# 3. フォームに画像フィールド追加
<%= form.file_field :image, class: "form-control" %>

# 4. Strong Parameters更新
def pokemon_params
  params.require(:pokemon).permit(:nickname, :species, :level, :image)
end
```

---

このガイドを使って、楽しく開発を進めてください！ 🎉
質問があれば、GitHubのIssuesで気軽に聞いてくださいね〜✨
