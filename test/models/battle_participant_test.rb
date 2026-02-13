require 'test_helper'

class BattleParticipantTest < ActiveSupport::TestCase
  setup do
    @participant = battle_participants(:one)
  end

  # === バリデーションテスト ===

  test '開始レベルが必須であること' do
    @participant.starting_level = nil
    assert_not @participant.valid?
  end

  test '終了レベルが必須であること' do
    @participant.ending_level = nil
    assert_not @participant.valid?
  end

  test 'レベルが1〜100であること' do
    @participant.starting_level = 0
    assert_not @participant.valid?

    @participant.starting_level = 101
    assert_not @participant.valid?
  end

  test 'ダメージが0以上であること' do
    @participant.damage_dealt = -1
    assert_not @participant.valid?
  end

  # === 関連テスト ===

  test 'バトルレコードに属すること' do
    assert_respond_to @participant, :battle_record
  end

  test 'ポケモンに属すること' do
    assert_respond_to @participant, :pokemon
  end

  # === メソッドテスト ===

  test 'level_gainedが正しく計算されること' do
    @participant.starting_level = 10
    @participant.ending_level = 12
    assert_equal 2, @participant.level_gained
  end

  test 'leveled_up?がレベルアップ判定すること' do
    @participant.starting_level = 10
    @participant.ending_level = 12
    assert @participant.leveled_up?

    @participant.ending_level = 10
    assert_not @participant.leveled_up?
  end

  test 'hp_lostがHP減少量を返すこと' do
    @participant.starting_hp = 100
    @participant.ending_hp = 30
    assert_equal 70, @participant.hp_lost
  end

  test 'performance_ratingが0〜10の範囲であること' do
    rating = @participant.performance_rating
    assert_operator rating, :>=, 0
    assert_operator rating, :<=, 10
  end

  test 'performance_gradeがS/A/B/C/Dのいずれかであること' do
    assert_includes %w[S A B C D], @participant.performance_grade
  end
end
