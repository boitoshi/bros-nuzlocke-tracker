module PokemonsHelper
  # ポケモンのステータスに応じたバッジクラスを返す
  def pokemon_status_badge(status)
    case status
    when "alive" then "bg-success"
    when "dead" then "bg-danger"
    when "boxed" then "bg-warning text-dark"
    else "bg-secondary"
    end
  end

  # ポケモンのステータスに応じたアイコンを返す
  def pokemon_status_icon(status)
    case status
    when "alive" then "💚"
    when "dead" then "💀"
    when "boxed" then "📦"
    else "❓"
    end
  end

  # ポケモンのステータス表示名を返す
  def pokemon_status_display(status)
    case status
    when "alive" then "生存"
    when "dead" then "死亡"
    when "boxed" then "ボックス"
    else "不明"
    end
  end
end
