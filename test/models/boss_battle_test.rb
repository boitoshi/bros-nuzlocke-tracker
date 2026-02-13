require 'test_helper'

class BossBattleTest < ActiveSupport::TestCase
  setup do
    @boss = boss_battles(:one)
  end

  # === バリデーションテスト ===

  test '名前が必須であること' do
    @boss.name = nil
    assert_not @boss.valid?
    assert_includes @boss.errors[:name], "can't be blank"
  end

  test 'ボスタイプが必須であること' do
    @boss.boss_type = nil
    assert_not @boss.valid?
  end

  test 'ゲームタイトルが必須であること' do
    @boss.game_title = nil
    assert_not @boss.valid?
  end

  test 'ゲームタイトルが許可リストに含まれること' do
    @boss.game_title = 'invalid'
    assert_not @boss.valid?
  end

  test '難易度0は無効であること' do
    @boss.difficulty = 0
    assert_not @boss.valid?
    assert_includes @boss.errors[:difficulty], 'is not included in the list'
  end

  test '難易度6は無効であること' do
    @boss.difficulty = 6
    assert_not @boss.valid?
    assert_includes @boss.errors[:difficulty], 'is not included in the list'
  end

  test '難易度3は有効であること' do
    boss = BossBattle.new(
      name: 'テストボス',
      boss_type: 'gym_leader',
      game_title: 'red',
      level: 14,
      difficulty: 3
    )
    # 難易度のバリデーションのみチェック
    boss.valid?
    assert_empty boss.errors[:difficulty]
  end

  test 'レベルが1〜100であること' do
    @boss.level = 0
    assert_not @boss.valid?

    @boss.level = 101
    assert_not @boss.valid?
  end

  # === enumテスト ===

  test 'ボスタイプのenum値が正しいこと' do
    assert_equal 0, BossBattle.boss_types['gym_leader']
    assert_equal 1, BossBattle.boss_types['elite_four']
    assert_equal 2, BossBattle.boss_types['champion']
  end

  # === 関連テスト ===

  test '攻略ガイドを複数持てること' do
    assert_respond_to @boss, :strategy_guides
  end

  test 'バトルレコードを複数持てること' do
    assert_respond_to @boss, :battle_records
  end

  # === スコープテスト ===

  test 'by_gameスコープがゲーム別にフィルタすること' do
    bosses = BossBattle.by_game('red')
    bosses.each do |b|
      assert_equal 'red', b.game_title
    end
  end

  # === メソッドテスト ===

  test 'boss_type_displayが日本語を返すこと' do
    @boss.boss_type = 'gym_leader'
    assert_equal 'ジムリーダー', @boss.boss_type_display

    @boss.boss_type = 'champion'
    assert_equal 'チャンピオン', @boss.boss_type_display
  end

  test 'boss_type_iconが絵文字を返すこと' do
    @boss.boss_type = 'gym_leader'
    assert_equal '🏟️', @boss.boss_type_icon

    @boss.boss_type = 'champion'
    assert_equal '🏆', @boss.boss_type_icon
  end

  test 'difficulty_infoがハッシュを返すこと' do
    info = @boss.difficulty_info
    assert_kind_of Hash, info
    assert info.key?(:name)
    assert info.key?(:color)
    assert info.key?(:icon)
  end
end
