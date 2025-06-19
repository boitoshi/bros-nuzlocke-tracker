# ⚡ 開発クイックリファレンス

## 🔥 よく使うコマンド一覧

```bash
# 🖥️ サーバー・コンソール
bin/rails server                 # 開発サーバー起動
bin/rails console               # Railsコンソール

# 🗄️ データベース
bin/rails db:migrate            # マイグレーション実行
bin/rails db:seed              # 初期データ投入
bin/rails db:reset             # DB完全リセット
bin/rails db:rollback          # マイグレーション取り消し

# 🧪 テスト
bin/rails test                 # 全テスト実行
bin/rails test test/models/    # モデルテストのみ
bin/rails test test/controllers/ # コントローラーテストのみ

# 🎨 アセット
yarn install                   # JS依存関係更新
bin/rails assets:precompile    # アセットビルド
bin/rails assets:clobber       # アセットキャッシュクリア

# 🔧 生成コマンド
bin/rails generate model Name field:type
bin/rails generate controller Names action1 action2
bin/rails generate migration AddFieldToModel field:type
```

## 📁 重要ファイル場所

```
app/
├── controllers/              # ビジネスロジック
│   ├── challenges_controller.rb
│   ├── pokemons_controller.rb  
│   └── dashboard_controller.rb
├── models/                   # データモデル
│   ├── challenge.rb
│   ├── pokemon.rb
│   └── user.rb
├── views/                    # 画面表示
│   ├── challenges/
│   ├── pokemons/
│   └── layouts/application.html.erb
└── assets/stylesheets/       # CSS
    └── application.scss

config/
├── routes.rb                 # URL設定
└── database.yml              # DB設定
```

## 🎯 機能追加の基本手順

### 1️⃣ 新しいモデル追加
```bash
# 1. モデル生成
bin/rails generate model Pokemon nickname:string species:string level:integer

# 2. マイグレーション実行
bin/rails db:migrate

# 3. モデルファイル編集（バリデーション等）
# app/models/pokemon.rb
```

### 2️⃣ 新しいコントローラー追加
```bash
# 1. コントローラー生成
bin/rails generate controller Pokemons index show new create edit update destroy

# 2. ルート設定
# config/routes.rb に resources :pokemons 追加

# 3. アクション実装
# app/controllers/pokemons_controller.rb
```

### 3️⃣ 新しいページ追加
```bash
# 1. ビューファイル作成
# app/views/pokemons/index.html.erb

# 2. Bootstrap使用例
<div class="container">
  <div class="row">
    <div class="col-md-8">
      <div class="card">
        <div class="card-body">
          <!-- 内容 -->
        </div>
      </div>
    </div>
  </div>
</div>
```

## 🎨 Bootstrapクラス早見表

```erb
<!-- レイアウト -->
<div class="container">        <!-- 固定幅コンテナ -->
<div class="container-fluid">  <!-- 全幅コンテナ -->
<div class="row">              <!-- 行 -->
<div class="col-md-6">         <!-- 列（中画面で6/12幅） -->

<!-- ボタン -->
<%= link_to "保存", path, class: "btn btn-primary" %>
<%= link_to "編集", path, class: "btn btn-secondary" %>
<%= link_to "削除", path, class: "btn btn-danger" %>

<!-- フォーム -->
<div class="mb-3">
  <%= form.label :name, class: "form-label" %>
  <%= form.text_field :name, class: "form-control" %>
</div>

<!-- カード -->
<div class="card">
  <div class="card-header">タイトル</div>
  <div class="card-body">内容</div>
</div>

<!-- バッジ -->
<span class="badge bg-primary">プライマリ</span>
<span class="badge bg-success">成功</span>
<span class="badge bg-danger">危険</span>

<!-- アラート -->
<div class="alert alert-success">成功メッセージ</div>
<div class="alert alert-danger">エラーメッセージ</div>
```

## 🗄️ よく使うActiveRecordメソッド

```ruby
# データ取得
Pokemon.all                    # 全件取得
Pokemon.find(1)               # ID指定取得
Pokemon.find_by(name: "ピカチュウ")  # 条件指定取得
Pokemon.where(level: 5)       # 条件で絞り込み
Pokemon.order(:level)         # ソート
Pokemon.limit(10)             # 件数制限

# データ作成
pokemon = Pokemon.new(name: "ピカチュウ")
pokemon.save                  # 保存

Pokemon.create(name: "ピカチュウ")  # 作成と保存を同時

# データ更新
pokemon = Pokemon.find(1)
pokemon.update(name: "ライチュウ")

# データ削除
pokemon = Pokemon.find(1)
pokemon.destroy

# 統計・集計
Pokemon.count                 # 件数
Pokemon.group(:species).count # 種族別カウント
Pokemon.average(:level)       # レベル平均
Pokemon.maximum(:level)       # 最大レベル
```

## 🧪 テストの基本パターン

```ruby
# test/models/pokemon_test.rb
require "test_helper"

class PokemonTest < ActiveSupport::TestCase
  test "valid pokemon should be saved" do
    pokemon = Pokemon.new(nickname: "ピカちゃん", species: "ピカチュウ", level: 5)
    assert pokemon.valid?
  end

  test "nickname should be present" do
    pokemon = Pokemon.new(nickname: "", species: "ピカチュウ", level: 5)
    assert_not pokemon.valid?
  end
end

# test/controllers/pokemons_controller_test.rb
require "test_helper"

class PokemonsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get pokemons_url
    assert_response :success
  end

  test "should create pokemon" do
    assert_difference("Pokemon.count") do
      post pokemons_url, params: { pokemon: { nickname: "テスト", species: "ピカチュウ", level: 5 } }
    end
  end
end
```

## 🚀 デプロイ前チェックリスト

```bash
# ✅ ローカルテスト
bin/rails test

# ✅ アセット確認
RAILS_ENV=production bin/rails assets:precompile

# ✅ マイグレーション確認
bin/rails db:migrate:status

# ✅ Git操作
git status
git add .
git commit -m "適切なコミットメッセージ"
git push origin main

# ✅ 本番デプロイ後確認
# - Renderダッシュボードでビルド成功確認
# - サイトアクセス確認
# - 新機能動作確認
```

## 🐛 よくあるエラーと対処法

```bash
# ❌ サーバーが起動しない
# → Gemfileの依存関係エラー
bundle install

# ❌ マイグレーションエラー
# → データベースリセット
bin/rails db:drop db:create db:migrate db:seed

# ❌ アセットが読み込まれない
# → アセットリビルド
bin/rails assets:clobber
bin/rails assets:precompile

# ❌ テストエラー
# → フィクスチャ確認、データベース状態確認
bin/rails db:test:prepare

# ❌ ルーティングエラー
# → routes.rb確認
bin/rails routes | grep pokemon
```

## 💡 開発のコツ

1. **小さく始める**: 最小限の機能から実装
2. **テストを書く**: バグを早期発見
3. **コミットを細かく**: 変更履歴を明確に
4. **命名を意識**: わかりやすい変数名・メソッド名
5. **READMEを更新**: チーム開発では重要

## 🔗 参考リンク

- [Rails Guide (日本語)](https://railsguides.jp/)
- [Bootstrap 5 Documentation](https://getbootstrap.com/docs/5.0/)
- [Ruby on Rails API](https://api.rubyonrails.org/)
- [Render.com Docs](https://render.com/docs)

---
📚 詳細は [DEVELOPMENT_GUIDE.md](DEVELOPMENT_GUIDE.md) を参照してください！
