require 'test_helper'

class RuleTest < ActiveSupport::TestCase
  setup do
    @rule = rules(:one)
    @challenge = challenges(:one)
  end

  # === バリデーションテスト ===

  test '名前が必須であること' do
    @rule.name = nil
    assert_not @rule.valid?
    assert_includes @rule.errors[:name], "can't be blank"
  end

  test 'ルールタイプが必須であること' do
    @rule.rule_type = nil
    assert_not @rule.valid?
  end

  # === 関連テスト ===

  test 'チャレンジに属すること' do
    assert_respond_to @rule, :challenge
    assert_equal @challenge, @rule.challenge
  end

  # === スコープテスト ===

  test 'enabledスコープが有効なルールのみ返すこと' do
    Rule.enabled.each do |r|
      assert r.enabled
    end
  end

  # === 定数テスト ===

  test 'RULE_TYPESが適切なキーを持つこと' do
    assert Rule::RULE_TYPES.key?('basic')
    assert Rule::RULE_TYPES.key?('level')
    assert Rule::RULE_TYPES.key?('custom')
  end

  test 'DEFAULT_RULESが空でないこと' do
    assert_not_empty Rule::DEFAULT_RULES
  end
end
