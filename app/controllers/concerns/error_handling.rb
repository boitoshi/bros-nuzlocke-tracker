# frozen_string_literal: true

# アプリケーション共通のエラーハンドリング 🚨
module ErrorHandling
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActionController::ParameterMissing, with: :parameter_missing
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized if defined?(Pundit)
  end

  private

  def record_not_found(exception)
    logger.warn "Record not found: #{exception.message}"

    respond_to do |format|
      format.html { redirect_to root_path, alert: 'お探しのページが見つかりません 😢' }
      format.json { render json: { error: 'Record not found' }, status: :not_found }
    end
  end

  def parameter_missing(exception)
    logger.warn "Parameter missing: #{exception.message}"

    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path, alert: '必要なパラメータが不足しています') }
      format.json { render json: { error: 'Parameter missing' }, status: :bad_request }
    end
  end

  def user_not_authorized
    respond_to do |format|
      format.html { redirect_to root_path, alert: 'アクセス権限がありません 🚫' }
      format.json { render json: { error: 'Unauthorized' }, status: :forbidden }
    end
  end
end
