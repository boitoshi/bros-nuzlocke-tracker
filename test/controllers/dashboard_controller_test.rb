require "test_helper"

class DashboardControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    @challenge = challenges(:one)
    @pokemon = pokemons(:one)
  end

  test "should redirect to login when not authenticated" do
    get dashboard_url
    assert_redirected_to new_user_session_url
  end

  test "should get index when authenticated" do
    sign_in @user
    get dashboard_url
    assert_response :success
    assert_select "h1", /統計ダッシュボード/
  end

  test "should display challenge stats" do
    sign_in @user
    get dashboard_url
    assert_response :success
    
    # 統計カードが表示されることを確認
    assert_select ".card-title", /総チャレンジ数/
    assert_select ".card-title", /成功率/
    assert_select ".card-title", /総ポケモン数/
    assert_select ".card-title", /生存率/
  end

  test "should display charts" do
    sign_in @user
    get dashboard_url
    assert_response :success
    
    # グラフのcanvas要素が存在することを確認
    assert_select "canvas#gameTitleChart"
    assert_select "canvas#speciesChart"
    assert_select "canvas#levelChart"
    assert_select "canvas#monthlyChart"
  end

  test "should include Chart.js script" do
    sign_in @user
    get dashboard_url
    assert_response :success
    
    # Chart.jsのスクリプトが含まれることを確認
    assert_select "script[type='module']"
  end
end
