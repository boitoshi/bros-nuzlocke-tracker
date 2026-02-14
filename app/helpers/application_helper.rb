module ApplicationHelper
  # ゲストユーザー（デモユーザー）かどうかを判定
  def guest_user?
    current_user&.username == 'demouser'
  end
end
