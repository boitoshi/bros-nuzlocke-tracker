require 'test_helper'

class TypeEffectivenessTest < ActiveSupport::TestCase
  setup do
    @type_eff = type_effectivenesses(:one)
  end

  # === バリデーションテスト ===

  test '攻撃タイプが必須であること' do
    @type_eff.attacking_type = nil
    assert_not @type_eff.valid?
  end

  test '防御タイプが必須であること' do
    @type_eff.defending_type = nil
    assert_not @type_eff.valid?
  end

  test '倍率が必須であること' do
    @type_eff.effectiveness = nil
    assert_not @type_eff.valid?
  end

  test '攻撃タイプが有効なタイプであること' do
    @type_eff.attacking_type = 'invalid'
    assert_not @type_eff.valid?
  end

  test '防御タイプが有効なタイプであること' do
    @type_eff.defending_type = 'invalid'
    assert_not @type_eff.valid?
  end

  test '倍率が許可された値であること' do
    @type_eff.effectiveness = 3.0
    assert_not @type_eff.valid?
  end

  # === 定数テスト ===

  test 'POKEMON_TYPESが18タイプ含むこと' do
    assert_equal 18, TypeEffectiveness::POKEMON_TYPES.length
    assert_includes TypeEffectiveness::POKEMON_TYPES, 'fire'
    assert_includes TypeEffectiveness::POKEMON_TYPES, 'water'
    assert_includes TypeEffectiveness::POKEMON_TYPES, 'grass'
    assert_includes TypeEffectiveness::POKEMON_TYPES, 'fairy'
  end

  # === クラスメソッドテスト ===

  test 'get_effectivenessが倍率を返すこと' do
    effectiveness = TypeEffectiveness.get_effectiveness('fire', 'water')
    assert_kind_of Numeric, effectiveness
  end

  test 'get_effectivenessが不明な組み合わせでは1.0を返すこと' do
    effectiveness = TypeEffectiveness.get_effectiveness('unknown', 'unknown')
    assert_equal 1.0, effectiveness
  end

  # === スコープテスト ===

  test 'super_effectiveスコープが効果抜群のみ返すこと' do
    TypeEffectiveness.super_effective.each do |te|
      assert_includes [2.0, 4.0], te.effectiveness.to_f
    end
  end

  test 'not_very_effectiveスコープが今ひとつのみ返すこと' do
    TypeEffectiveness.not_very_effective.each do |te|
      assert_includes [0.25, 0.5], te.effectiveness.to_f
    end
  end

  test 'no_effectスコープが効果なしのみ返すこと' do
    no_effects = TypeEffectiveness.no_effect
    # スコープが正しいクエリを返すことを確認
    assert_kind_of ActiveRecord::Relation, no_effects
    no_effects.each do |te|
      assert_equal 0.0, te.effectiveness.to_f
    end
  end
end
