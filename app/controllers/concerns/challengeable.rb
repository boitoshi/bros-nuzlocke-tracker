# frozen_string_literal: true

# Challengeable Concern 🎯
# チャレンジに関連するコントローラーで共通して使用するモジュール
module Challengeable
  extend ActiveSupport::Concern

  included do
    before_action :set_challenge, if: :challenge_id_present?
  end

  private

  # チャレンジ設定の共通メソッド
  def set_challenge
    @challenge = current_user.challenges.find(params[:challenge_id])
  rescue ActiveRecord::RecordNotFound
    handle_challenge_not_found
  end

  # チャレンジが見つからない場合の処理
  def handle_challenge_not_found
    respond_to do |format|
      format.html { redirect_to challenges_path, alert: '指定されたチャレンジが見つかりません。' }
      format.json { render json: { error: 'Challenge not found' }, status: :not_found }
    end
  end

  # パラメータにchallenge_idが含まれているかチェック
  def challenge_id_present?
    params[:challenge_id].present?
  end

  # チャレンジのオーナーかどうかをチェック
  def ensure_challenge_owner
    return if @challenge && @challenge.user == current_user

    handle_unauthorized_challenge_access
  end

  # 不正なチャレンジアクセスの処理
  def handle_unauthorized_challenge_access
    respond_to do |format|
      format.html { redirect_to challenges_path, alert: 'このチャレンジにアクセスする権限がありません。' }
      format.json { render json: { error: 'Unauthorized' }, status: :unauthorized }
    end
  end

  # チャレンジが進行中かどうかをチェック
  def ensure_challenge_in_progress
    return if @challenge&.in_progress?

    respond_to do |format|
      format.html { redirect_to challenge_path(@challenge), alert: '完了または失敗したチャレンジは編集できません。' }
      format.json { render json: { error: 'Challenge not editable' }, status: :unprocessable_entity }
    end
  end

  # チャレンジ用のよく使うスコープを提供
  module ClassMethods
    def require_challenge_ownership
      before_action :ensure_challenge_owner
    end

    def require_active_challenge
      before_action :ensure_challenge_in_progress
    end
  end
end
