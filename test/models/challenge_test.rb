require 'test_helper'

class ChallengeTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @challenge = challenges(:one)
  end

  # === バリデーションテスト ===

  test 'チャレンジ名が必須であること' do
    challenge = Challenge.new(game_title: 'red', status: 'in_progress', user: @user, started_at: Time.current)
    assert_not challenge.valid?
    assert_includes challenge.errors[:name], "can't be blank"
  end

  test 'ゲームタイトルが必須であること' do
    challenge = Challenge.new(name: 'テスト', status: 'in_progress', user: @user, started_at: Time.current)
    assert_not challenge.valid?
    assert_includes challenge.errors[:game_title], "can't be blank"
  end

  test 'ゲームタイトルが許可リストに含まれること' do
    challenge = Challenge.new(name: 'テスト', game_title: 'invalid_game', status: 'in_progress', user: @user, started_at: Time.current)
    assert_not challenge.valid?
    assert_includes challenge.errors[:game_title], 'is not included in the list'
  end

  test '有効なゲームタイトルが受け入れられること' do
    %w[red green blue yellow gold silver crystal ruby sapphire emerald].each do |title|
      challenge = Challenge.new(name: 'テスト', game_title: title, status: 'in_progress', user: @user, started_at: Time.current)
      assert challenge.valid?, "#{title}は有効なゲームタイトルのはず: #{challenge.errors.full_messages}"
    end
  end

  test 'ステータスが必須であること' do
    challenge = Challenge.new(name: 'テスト', game_title: 'red', user: @user, started_at: Time.current)
    assert_not challenge.valid?
    assert_includes challenge.errors[:status], "can't be blank"
  end

  test '名前が100文字以内であること' do
    challenge = Challenge.new(name: 'あ' * 101, game_title: 'red', status: 'in_progress', user: @user, started_at: Time.current)
    assert_not challenge.valid?
  end

  # === enumテスト ===

  test 'ステータスのenum値が正しいこと' do
    assert_equal 0, Challenge.statuses['in_progress']
    assert_equal 1, Challenge.statuses['completed']
    assert_equal 2, Challenge.statuses['failed']
  end

  # === 関連テスト ===

  test 'ユーザーに属すること' do
    assert_respond_to @challenge, :user
    assert_equal @user, @challenge.user
  end

  test 'ポケモンを複数持てること' do
    assert_respond_to @challenge, :pokemons
  end

  test 'ルールを複数持てること' do
    assert_respond_to @challenge, :rules
  end

  test 'マイルストーンを複数持てること' do
    assert_respond_to @challenge, :milestones
  end

  test 'イベントログを複数持てること' do
    assert_respond_to @challenge, :event_logs
  end

  # === スコープテスト ===

  test 'recentスコープが新しい順に返すこと' do
    challenges = Challenge.recent
    assert_operator challenges.first.created_at, :>=, challenges.last.created_at
  end

  # === メソッドテスト ===

  test 'game_title_displayが日本語名を返すこと' do
    @challenge.game_title = 'red'
    assert_equal 'ポケットモンスター 赤', @challenge.game_title_display
  end

  test 'survival_rateが正しく計算されること' do
    assert_kind_of Numeric, @challenge.survival_rate
  end

  test 'can_add_to_party?がパーティ枠を判定すること' do
    assert_includes [true, false], @challenge.can_add_to_party?
  end

  test 'party_slots_availableが0〜6の値を返すこと' do
    slots = @challenge.party_slots_available
    assert_operator slots, :>=, 0
    assert_operator slots, :<=, 6
  end
end
