# ユーザーモデルのテスト 👤
require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(
      username: "testuser",
      email: "test@example.com",
      password: "password123",
      password_confirmation: "password123"
    )
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "username should be present" do
    @user.username = ""
    assert_not @user.valid?
  end

  test "username should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "username should accept valid format" do
    valid_usernames = %w[user123 test_user validUser]
    valid_usernames.each do |username|
      @user.username = username
      assert @user.valid?, "#{username} should be valid"
    end
  end

  test "username should reject invalid format" do
    invalid_usernames = %w[user-123 test@user invalid\ user user.]
    invalid_usernames.each do |username|
      @user.username = username
      assert_not @user.valid?, "#{username} should be invalid"
    end
  end

  test "email should be unique" do
    duplicate_user = @user.dup
    duplicate_user.username = "different"
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email should accept valid format" do
    valid_emails = %w[user@example.com TEST@FOO.COM A_US-ER@f.b.org first.last@foo.jp]
    valid_emails.each do |email|
      @user.email = email
      assert @user.valid?, "#{email} should be valid"
    end
  end

  test "email should reject invalid format" do
    invalid_emails = %w[user@example,com user_at_foo.org user.name@example. foo@bar+baz.com]
    invalid_emails.each do |email|
      @user.email = email
      assert_not @user.valid?, "#{email} should be invalid"
    end
  end

  test "password should be present" do
    @user.password = ""
    @user.password_confirmation = ""
    assert_not @user.valid?
  end

  test "password should have minimum length" do
    @user.password = "12345"
    @user.password_confirmation = "12345"
    assert_not @user.valid?
  end

  test "display_name should return username when present" do
    assert_equal @user.username, @user.display_name
  end

  test "display_name should return email prefix when username is blank" do
    @user.username = ""
    expected = @user.email.split("@").first
    assert_equal expected, @user.display_name
  end

  test "should find user by username or email" do
    @user.save
    
    # ユーザー名で検索
    found_user = User.find_for_database_authentication(email: @user.username)
    assert_equal @user, found_user
    
    # メールで検索
    found_user = User.find_for_database_authentication(email: @user.email)
    assert_equal @user, found_user
    
    # 大文字小文字を無視
    found_user = User.find_for_database_authentication(email: @user.email.upcase)
    assert_equal @user, found_user
  end

  test "should have many challenges" do
    assert_respond_to @user, :challenges
  end

  test "should destroy associated challenges when user is destroyed" do
    @user.save
    challenge = @user.challenges.create!(name: "Test Challenge", game_title: "emerald")
    assert_difference 'Challenge.count', -1 do
      @user.destroy
    end
  end
end
