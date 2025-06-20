class ApplicationController < ActionController::Base
  # シンプルにするため、ブラウザ制限は無効化
  # allow_browser versions: :modern
  
  # Devise用のストロングパラメータ設定
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    # サインアップ時にusernameを許可
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    # アカウント更新時にusernameを許可  
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end

  # ゲストユーザー（デモユーザー）かどうかを判定
  def guest_user?
    user_signed_in? && current_user.username == 'demouser'
  end
  helper_method :guest_user?

  # 通常のユーザー（ゲストユーザー以外）かどうかを判定
  def regular_user?
    user_signed_in? && !guest_user?
  end
  helper_method :regular_user?
end
