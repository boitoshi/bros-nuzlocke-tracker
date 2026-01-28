# frozen_string_literal: true

# Pokemonの認可ポリシー
# ポケモンはチャレンジに紐づくため、チャレンジの所有者のみが操作可能
class PokemonPolicy < ApplicationPolicy
  # 一覧表示は所有者のみ
  def index?
    owner_through_challenge?
  end

  # 詳細表示は所有者のみ
  def show?
    owner_through_challenge?
  end

  # 新規作成は所有者のみ
  def create?
    owner_through_challenge?
  end

  # 編集は所有者のみ
  def update?
    owner_through_challenge?
  end

  # 削除は所有者のみ
  def destroy?
    owner_through_challenge?
  end

  # パーティ追加/削除は所有者のみ
  def toggle_party?
    owner_through_challenge?
  end

  # 状態変更（死亡、ボックス）は所有者のみ
  def mark_as_dead?
    owner_through_challenge?
  end

  def mark_as_boxed?
    owner_through_challenge?
  end

  # パーティ一覧表示は所有者のみ
  def party?
    owner_through_challenge?
  end

  # Scopeでユーザー自身のポケモンのみを取得
  class Scope < ApplicationPolicy::Scope
    def resolve
      # ユーザーのチャレンジに紐づくポケモンのみ
      scope.joins(:challenge).where(challenges: { user: user })
    end
  end

  private

  # チャレンジを通じて所有者かどうかをチェック
  def owner_through_challenge?
    user.present? && record.challenge.user_id == user.id
  end
end
