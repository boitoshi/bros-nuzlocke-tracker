# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Pundit認可を有効化
  include Pundit::Authorization

  # シンプルにするため、ブラウザ制限は無効化
  # allow_browser versions: :modern

  # セキュリティヘッダーの設定
  before_action :set_security_headers

  # Devise用のストロングパラメータ設定
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Punditの認可エラーをハンドリング
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

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

  private

  def set_security_headers
    response.headers['X-Content-Type-Options'] = 'nosniff'
    response.headers['X-Frame-Options'] = 'DENY'
    response.headers['X-XSS-Protection'] = '1; mode=block'
    response.headers['Referrer-Policy'] = 'strict-origin-when-cross-origin'
  end

  # Pundit認可エラー時の処理
  def user_not_authorized
    flash[:alert] = 'このアクションを実行する権限がありません。'
    redirect_to(request.referrer || root_path)
  end
end
