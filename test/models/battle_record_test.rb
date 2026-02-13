require 'test_helper'

class BattleRecordTest < ActiveSupport::TestCase
  setup do
    @battle_record = battle_records(:one)
    @challenge = challenges(:one)
  end

  # === バリデーションテスト ===

  test '対戦相手名が必須であること' do
    @battle_record.opponent_name = nil
    assert_not @battle_record.valid?
    assert_includes @battle_record.errors[:opponent_name], "can't be blank"
  end

  test '対戦相手名が100文字以内であること' do
    @battle_record.opponent_name = 'あ' * 101
    assert_not @battle_record.valid?
  end

  test 'バトル日時が必須であること' do
    @battle_record.battle_date = nil
    assert_not @battle_record.valid?
  end

  test 'バトルタイプが必須であること' do
    @battle_record.battle_type = nil
    assert_not @battle_record.valid?
  end

  test '結果が必須であること' do
    @battle_record.result = nil
    assert_not @battle_record.valid?
  end

  test '難易度が1〜5であること' do
    @battle_record.difficulty_rating = 0
    assert_not @battle_record.valid?

    @battle_record.difficulty_rating = 6
    assert_not @battle_record.valid?

    @battle_record.difficulty_rating = 3
    assert @battle_record.valid?
  end

  # === enumテスト ===

  test 'バトルタイプのenum値が正しいこと' do
    assert_equal 0, BattleRecord.battle_types['gym_battle']
    assert_equal 1, BattleRecord.battle_types['elite_four']
    assert_equal 2, BattleRecord.battle_types['champion']
  end

  test '結果のenum値が正しいこと' do
    assert_equal 0, BattleRecord.results['win']
    assert_equal 1, BattleRecord.results['loss']
  end

  # === 関連テスト ===

  test 'チャレンジに属すること' do
    assert_respond_to @battle_record, :challenge
    assert_equal @challenge, @battle_record.challenge
  end

  test 'ボスバトルに任意で属すること' do
    assert_respond_to @battle_record, :boss_battle
  end

  test 'バトル参加者を複数持てること' do
    assert_respond_to @battle_record, :battle_participants
  end

  # === スコープテスト ===

  test 'recentスコープがバトル日時の新しい順に返すこと' do
    records = BattleRecord.recent.to_a
    records.each_cons(2) do |a, b|
      assert_operator a.battle_date, :>=, b.battle_date
    end
  end

  test 'victoriesスコープが勝利のみ返すこと' do
    victories = BattleRecord.victories
    # スコープが正しいクエリを返すことを確認
    assert_kind_of ActiveRecord::Relation, victories
    victories.each do |r|
      assert_equal 'win', r.result
    end
  end

  # === メソッドテスト ===

  test 'battle_type_displayが日本語を返すこと' do
    @battle_record.battle_type = 'gym_battle'
    assert_equal 'ジム戦', @battle_record.battle_type_display
  end

  test 'result_displayが日本語を返すこと' do
    @battle_record.result = 'win'
    assert_equal '勝利', @battle_record.result_display

    @battle_record.result = 'loss'
    assert_equal '敗北', @battle_record.result_display
  end

  test 'difficulty_starsが星を返すこと' do
    @battle_record.difficulty_rating = 3
    assert_equal '⭐⭐⭐', @battle_record.difficulty_stars
  end
end
