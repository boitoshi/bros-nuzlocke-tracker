class Rule < ApplicationRecord
  belongs_to :challenge

  # ルールタイプの定義
  RULE_TYPES = {
    "basic" => "基本ルール",
    "level" => "レベル制限",
    "item" => "アイテム制限",
    "pokemon_center" => "ポケモンセンター制限",
    "evolution" => "進化制限",
    "duplicate" => "重複ポケモン制限",
    "battle_style" => "バトルスタイル",
    "exp_share" => "経験値共有",
    "wild_battle" => "野生ポケモン戦制限",
    "custom" => "カスタムルール"
  }.freeze

  # デフォルトルールの定義
  DEFAULT_RULES = [
    {
      name: "ポケモンが瀕死になったら死亡扱い",
      description: "バトルでHPが0になったポケモンは「死亡」として扱い、二度と使用できません。",
      rule_type: "basic",
      default_value: "true",
      sort_order: 1
    },
    {
      name: "1エリア1匹ルール",
      description: "同じエリア（ルート、街、ダンジョンなど）では最初に遭遇したポケモン1匹のみ捕獲可能です。",
      rule_type: "basic",
      default_value: "true",
      sort_order: 2
    },
    {
      name: "ニックネーム必須",
      description: "捕獲したポケモンには必ずニックネームをつけてください。",
      rule_type: "basic",
      default_value: "true",
      sort_order: 3
    },
    {
      name: "レベル制限",
      description: "ジムリーダーのエースポケモンより高いレベルで挑戦することを禁止します。",
      rule_type: "level",
      default_value: "false",
      sort_order: 10
    },
    {
      name: "回復アイテム制限",
      description: "バトル中の回復アイテムの使用を制限します。",
      rule_type: "item",
      default_value: "false",
      sort_order: 20
    },
    {
      name: "ポケモンセンター制限",
      description: "ポケモンセンターでの回復回数を制限します。",
      rule_type: "pokemon_center",
      default_value: "false",
      sort_order: 30
    },
    {
      name: "進化制限",
      description: "ポケモンの進化を禁止または制限します。",
      rule_type: "evolution",
      default_value: "false",
      sort_order: 40
    },
    {
      name: "重複ポケモン制限",
      description: "同じ種族のポケモンを複数匹捕獲することを禁止します。",
      rule_type: "duplicate",
      default_value: "false",
      sort_order: 50
    }
  ].freeze

  # バリデーション
  validates :name, presence: true, length: { minimum: 1, maximum: 100 }
  validates :rule_type, presence: true, inclusion: { in: RULE_TYPES.keys }
  validates :enabled, inclusion: { in: [ true, false ] }
  validates :sort_order, presence: true, numericality: { greater_than_or_equal_to: 0 }

  # スコープ
  scope :enabled, -> { where(enabled: true) }
  scope :disabled, -> { where(enabled: false) }
  scope :by_type, ->(type) { where(rule_type: type) }
  scope :ordered, -> { order(:sort_order, :created_at) }

  # メソッド
  def rule_type_display
    RULE_TYPES[rule_type] || rule_type
  end

  def active_value
    (custom_value.presence || default_value)
  end

  def boolean_value?
    active_value.in?([ "true", "false" ])
  end

  def boolean_active?
    active_value == "true"
  end

  def numeric_value?
    active_value.to_s.match?(/\A\d+\z/)
  end

  def numeric_active_value
    numeric_value? ? active_value.to_i : 0
  end

  # チャレンジにデフォルトルールを作成
  def self.create_default_rules_for_challenge(challenge)
    DEFAULT_RULES.each do |rule_data|
      challenge.rules.create!(
        name: rule_data[:name],
        description: rule_data[:description],
        rule_type: rule_data[:rule_type],
        default_value: rule_data[:default_value],
        enabled: rule_data[:default_value] == "true",
        sort_order: rule_data[:sort_order]
      )
    end
  end

  # ルール違反チェック
  def violation_check(pokemon, action = nil)
    return [] unless enabled?

    violations = []

    case rule_type
    when "basic"
      violations.concat(check_basic_rule_violations(pokemon, action))
    when "level"
      violations.concat(check_level_violations(pokemon))
    when "duplicate"
      violations.concat(check_duplicate_violations(pokemon))
    end

    violations
  end

  private

  def check_basic_rule_violations(pokemon, action)
    violations = []

    case name
    when "ポケモンが瀕死になったら死亡扱い"
      if action == :revive && pokemon.dead?
        violations << "#{pokemon.display_name}は既に死亡しているため、使用できません。"
      end
    when "ニックネーム必須"
      if pokemon.nickname.blank?
        violations << "#{pokemon.species}にニックネームをつけてください。"
      end
    end

    violations
  end

  def check_level_violations(pokemon)
    violations = []

    if enabled? && numeric_value? && pokemon.level > numeric_active_value
      violations << "#{pokemon.display_name}のレベル(#{pokemon.level})が制限レベル(#{numeric_active_value})を超えています。"
    end

    violations
  end

  def check_duplicate_violations(pokemon)
    violations = []

    if enabled?
      same_species_count = challenge.pokemons.where(species: pokemon.species).where.not(id: pokemon.id).count
      if same_species_count > 0
        violations << "#{pokemon.species}は既に捕獲済みです。重複ポケモン制限により捕獲できません。"
      end
    end

    violations
  end
end
