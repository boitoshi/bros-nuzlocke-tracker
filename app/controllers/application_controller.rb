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
end
