module PokemonsHelper
  # ポケモンのスプライト画像タグ 🖼️
  # PokeAPI GitHub CDNからスプライトを取得
  def pokemon_sprite_tag(pokemon, size: 48, css_class: "pokemon-sprite")
    url = pokemon.sprite_url
    if url
      tag.img(src: url, alt: pokemon.species, 
              width: size, height: size, 
              class: css_class, loading: "lazy",
              onerror: "this.style.display='none'")
    else
      tag.span("?", class: "#{css_class} sprite-fallback",
               style: "width:#{size}px;height:#{size}px;display:inline-flex;align-items:center;justify-content:center;font-size:#{size/2}px;background:rgba(0,0,0,0.1);border-radius:50%;")
    end
  end

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
