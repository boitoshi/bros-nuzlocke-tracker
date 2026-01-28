# frozen_string_literal: true

# Challengeの認可ポリシー
# ユーザーは自分のチャレンジのみ操作可能
class ChallengePolicy < ApplicationPolicy
  # 全てのチャレンジを一覧表示できる（自分のもののみ）
  def index?
    true
  end

  # チャレンジの詳細を見れるのは所有者のみ
  def show?
    owner?
  end

  # 新規作成はログインユーザー全員が可能
  def create?
    user.present?
  end

  # 編集できるのは所有者のみ
  def update?
    owner?
  end

  # 削除できるのは所有者のみ
  def destroy?
    owner?
  end

  # チャレンジステータスを変更できるのは所有者のみ
  def complete?
    owner?
  end

  def fail?
    owner?
  end

  # Scopeでユーザー自身のチャレンジのみを取得
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.where(user: user)
    end
  end

  private

  # チャレンジの所有者かどうかをチェック
  def owner?
    user.present? && record.user_id == user.id
  end
end
