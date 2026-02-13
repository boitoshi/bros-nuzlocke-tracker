require "test_helper"

class BattleRecordsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    @challenge = challenges(:one)
    @battle_record = battle_records(:one)
    sign_in @user
  end

  test "should get index" do
    get challenge_battle_records_url(@challenge)
    assert_response :success
  end

  test "should get show" do
    get challenge_battle_record_url(@challenge, @battle_record)
    assert_response :success
  end

  test "should get new" do
    get new_challenge_battle_record_url(@challenge)
    assert_response :success
  end

  test "should create battle_record" do
    assert_difference("BattleRecord.count") do
      post challenge_battle_records_url(@challenge), params: {
        battle_record: {
          opponent_name: "テストトレーナー",
          battle_type: "trainer",
          result: "win",
          battle_date: Time.current,
          difficulty_rating: 3
        }
      }
    end
    assert_redirected_to challenge_battle_record_url(@challenge, BattleRecord.last)
  end

  test "should get edit" do
    get edit_challenge_battle_record_url(@challenge, @battle_record)
    assert_response :success
  end

  test "should update battle_record" do
    patch challenge_battle_record_url(@challenge, @battle_record), params: {
      battle_record: { opponent_name: "更新トレーナー" }
    }
    assert_redirected_to challenge_battle_record_url(@challenge, @battle_record)
  end

  test "should redirect when not authenticated" do
    sign_out @user
    get challenge_battle_records_url(@challenge)
    assert_redirected_to new_user_session_url
  end
end
