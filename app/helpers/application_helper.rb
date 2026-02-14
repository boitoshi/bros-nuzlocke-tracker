module ApplicationHelper
  # ゲストユーザー（デモユーザー）かどうかを判定
  def guest_user?
    current_user&.username == 'demouser'
  end

  # 現在のアクティブチャレンジからゲームテーマを取得
  def current_game_theme
    return nil unless user_signed_in?

    # チャレンジ詳細ページの場合
    if @challenge
      return @challenge.game_title
    end

    # それ以外は最新の進行中チャレンジのテーマ
    current_user.challenges.where(status: :in_progress).order(updated_at: :desc).first&.game_title
  end

  # ゲームテーマの表示名
  def game_theme_display(theme)
    case theme
    when "red" then "赤"
    when "green" then "緑"
    when "blue" then "青"
    when "yellow" then "ピカチュウ"
    when "gold" then "金"
    when "silver" then "銀"
    when "crystal" then "クリスタル"
    when "ruby" then "ルビー"
    when "sapphire" then "サファイア"
    when "emerald" then "エメラルド"
    else theme
    end
  end
end
