require "test_helper"

class TeamBuilderControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get team_builder_index_url
    assert_response :success
  end

  test "should get analyze" do
    get team_builder_analyze_url
    assert_response :success
  end

  test "should get suggest" do
    get team_builder_suggest_url
    assert_response :success
  end
end
