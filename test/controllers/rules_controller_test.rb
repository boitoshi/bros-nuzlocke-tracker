require "test_helper"

class RulesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    @challenge = challenges(:one)
    @rule = rules(:one)
    sign_in @user
  end

  test "should get index" do
    get challenge_rules_url(@challenge)
    assert_response :success
  end

  test "should get show" do
    get challenge_rule_url(@challenge, @rule)
    assert_response :success
  end

  test "should get edit" do
    get edit_challenge_rule_url(@challenge, @rule)
    assert_response :success
  end

  test "should update rule" do
    patch challenge_rule_url(@challenge, @rule), params: {
      rule: { enabled: false }
    }
    assert_redirected_to challenge_rules_url(@challenge)
  end

  test "should redirect when not authenticated" do
    sign_out @user
    get challenge_rules_url(@challenge)
    assert_redirected_to new_user_session_url
  end
end
