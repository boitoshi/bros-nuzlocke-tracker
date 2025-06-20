class GuestSessionsController < ApplicationController
  # ゲストログイン機能 - デバッグ・デモ用 🎮
  
  def create
    # デモユーザーとしてログイン
    demo_user = User.find_by(username: 'demouser')
    
    if demo_user
      sign_in(demo_user)
      redirect_to root_path, notice: '🎮 ゲストユーザーとしてログインしました！デモ機能をお楽しみください ✨'
    else
      # デモユーザーが存在しない場合は作成
      begin
        demo_user = create_demo_user
        sign_in(demo_user)
        redirect_to root_path, notice: '🎮 ゲストユーザーを作成してログインしました！デモ機能をお楽しみください ✨'
      rescue StandardError => e
        Rails.logger.error "Failed to create demo user: #{e.message}"
        redirect_to root_path, alert: '❌ ゲストログインに失敗しました。しばらく時間をおいて再度お試しください。'
      end
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

  private

  def create_demo_user
    User.create!(
      username: 'demouser',
      email: 'demo@example.com',
      password: 'DemoPass123!',
      password_confirmation: 'DemoPass123!'
    )
  end
end