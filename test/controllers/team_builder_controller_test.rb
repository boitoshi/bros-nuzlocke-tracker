require "test_helper"

class TeamBuilderControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    @challenge = challenges(:one)
    sign_in @user
  end

  test "should get index" do
    get challenge_team_builder_url(@challenge)
    assert_response :success
  end

  test "should get analyze" do
    get challenge_team_builder_analyze_url(@challenge)
    assert_response :success
  end

  test "should get suggest" do
    get challenge_team_builder_suggest_url(@challenge)
    assert_response :success
  end

  test "should redirect when not authenticated" do
    sign_out @user
    get challenge_team_builder_url(@challenge)
    assert_redirected_to new_user_session_url
  end
end
