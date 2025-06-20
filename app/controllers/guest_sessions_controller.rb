class GuestSessionsController < ApplicationController
  # ゲストログイン機能 - デバッグ・デモ用 🎮
  
  def create
    # デモユーザーとしてログイン
    demo_user = User.find_by(username: 'demouser')
    
    if demo_user
      sign_in(demo_user)
      redirect_to root_path, notice: '🎮 ゲストユーザーとしてログインしました！デモ機能をお楽しみください ✨'
    else
      redirect_to root_path, alert: '❌ ゲストユーザーが見つかりません。管理者にお問い合わせください。'
    end
  end
  
  def destroy
    if user_signed_in? && current_user.username == 'demouser'
      sign_out(current_user)
      redirect_to root_path, notice: '👋 ゲストセッションを終了しました。'
    else
      redirect_to root_path
    end
  end
end