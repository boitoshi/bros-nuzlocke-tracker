# テストガイド

## 🧪 テストの実行方法

### 全テストの実行
```bash
bundle exec rails test
```

### 特定のテストファイルの実行
```bash
# モデルテスト
bundle exec rails test test/models/challenge_test.rb
bundle exec rails test test/models/pokemon_test.rb

# Policyテスト
bundle exec rails test test/policies/challenge_policy_test.rb
bundle exec rails test test/policies/pokemon_policy_test.rb

# コントローラーテスト
bundle exec rails test test/controllers/challenges_controller_test.rb
```

### テストディレクトリ全体の実行
```bash
# 全モデルテスト
bundle exec rails test test/models/

# 全Policyテスト
bundle exec rails test test/policies/

# 全コントローラーテスト
bundle exec rails test test/controllers/
```

## 📊 テストカバレッジ

### 現在のテスト状況 (2026-01-28)
- **総テスト数**: 44テスト
- **成功率**: 100% ✅
- **主要カバレッジ**:
  - Policyテスト: 19テスト
  - Challengeモデルテスト: 13テスト
  - Pokemonモデルテスト: 13テスト

### テストカテゴリ

#### 1. Policyテスト (認可)
場所: `test/policies/`
- ChallengePolicyTest: 11テスト
- PokemonPolicyTest: 8テスト

**テスト内容**:
- 所有者のみがリソースにアクセス可能
- 非所有者のアクセス拒否
- Scopeによるデータの適切なフィルタリング

#### 2. モデルテスト
場所: `test/models/`

**ChallengeTest** (13テスト):
- バリデーション（name、game_title、started_at）
- ステータス管理
- 期間計算
- リレーションシップ
- 依存削除

**PokemonTest** (13テスト):
- バリデーション（species、level、IVs、EVs）
- ステータス管理
- パーティ参加判定
- 表示名生成
- リレーションシップ

#### 3. コントローラーテスト
場所: `test/controllers/`
- 今後実装予定

#### 4. 統合テスト
場所: `test/integration/`
- 今後実装予定

## 🎯 テストのベストプラクティス

### 1. テストの命名規則
```ruby
test '説明文（日本語可）' do
  # テストコード
end
```

### 2. セットアップメソッドの使用
```ruby
def setup
  @user = users(:testuser)
  @challenge = challenges(:emerald_challenge)
end
```

### 3. フィクスチャーの活用
場所: `test/fixtures/`
- `users.yml`: テストユーザー
- `challenges.yml`: テストチャレンジ
- `pokemons.yml`: テストポケモン

### 4. アサーションの選択
```ruby
# 推奨されるアサーション
assert @object.valid?                 # オブジェクトが有効
assert_not @object.valid?             # オブジェクトが無効
assert_includes array, element        # 配列に要素が含まれる
assert_equal expected, actual         # 値が等しい
assert_difference 'Model.count', 1    # カウントが変化

# エラーメッセージの確認
assert_includes @object.errors[:field], 'message'
```

## 🚀 テスト作成時のチェックリスト

### 新しいモデルテストを作成する際
- [ ] 全てのバリデーションをテスト
- [ ] 各enumの状態をテスト
- [ ] カスタムメソッドの動作をテスト
- [ ] リレーションシップをテスト
- [ ] 依存削除(dependent: :destroy)をテスト
- [ ] スコープをテスト

### 新しいPolicyテストを作成する際
- [ ] index?アクションをテスト
- [ ] show?アクションをテスト
- [ ] create?アクションをテスト
- [ ] update?アクションをテスト
- [ ] destroy?アクションをテスト
- [ ] カスタムアクションをテスト
- [ ] Scopeをテスト
- [ ] 所有者と非所有者の両方をテスト

### 新しいコントローラーテストを作成する際
- [ ] 全てのアクションをテスト
- [ ] 正常系をテスト
- [ ] 異常系をテスト
- [ ] 認証が必要なアクションの保護をテスト
- [ ] 認可が正しく機能することをテスト
- [ ] リダイレクトとフラッシュメッセージをテスト

## 💡 テストのトラブルシューティング

### フィクスチャーエラー
```bash
# テストデータベースをリセット
bin/rails db:test:prepare
```

### 並列実行の問題
```ruby
# test_helper.rbで並列実行を無効化（必要な場合のみ）
# parallelize(workers: :number_of_processors) をコメントアウト
```

### テストデータの競合
```ruby
# トランザクションロールバックを確認
# ActiveSupport::TestCaseでは自動的に実施される
```

## 📈 今後の改善計画

### 短期 (1-2週間)
- [ ] コントローラーテストの追加
- [ ] Serviceクラスのテスト追加
- [ ] システムテスト（E2E）の追加

### 中期 (1-2ヶ月)
- [ ] テストカバレッジツール（SimpleCov）の導入
- [ ] CI/CDパイプラインへのテスト統合
- [ ] パフォーマンステストの追加

### 長期 (3-6ヶ月)
- [ ] テストカバレッジ80%以上を目標
- [ ] 統合テストの充実
- [ ] 負荷テストの実施

## 🛠️ 便利なコマンド

```bash
# テストをverboseモードで実行
bundle exec rails test -v

# 特定のテストのみを実行（行番号指定）
bundle exec rails test test/models/pokemon_test.rb:40

# 失敗したテストのみを再実行
bundle exec rails test --fail-fast

# テスト実行時のログレベルを変更
RAILS_LOG_LEVEL=debug bundle exec rails test
```
