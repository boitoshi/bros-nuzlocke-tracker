# 🎮 ポケモン図鑑データベース設計 (JSON対応版)

## � **データソース**
- [boitoshi/pokemon-data](https://github.com/boitoshi/pokemon-data) のJSON形式を活用
- PostgreSQL の JSON型を駆使した効率的設計

## �📊 **メインテーブル設計**

### 1. **PokemonSpecies (ポケモン種族)**
```ruby
# rails generate model PokemonSpecies national_id:integer name_ja:string name_en:string types:json stats:json abilities:json category:string height:float weight:float description:text image_url:string generation:integer is_legendary:boolean is_mythical:boolean
```

| カラム名 | 型 | 説明 | 例 |
|---------|----|----|-----|
| national_id | integer | 全国図鑑番号 | 25 |
| name_ja | string | 日本語名 | "ピカチュウ" |
| name_en | string | 英語名 | "Pikachu" |
| **types** | **json** | **タイプ配列** | **["でんき"]** |
| **stats** | **json** | **種族値JSON** | **{"hp":35, "attack":55, ...}** |
| **abilities** | **json** | **特性配列** | **[{"name":"せいでんき", "hidden":false}, ...]** |
| category | string | 分類 | "ねずみポケモン" |
| height | float | 高さ(m) | 0.4 |
| weight | float | 重さ(kg) | 6.0 |
| description | text | 図鑑説明 | "電気を頬の袋に..." |
| image_url | string | 画像URL | "https://..." |
| generation | integer | 世代 | 1 |
| is_legendary | boolean | 伝説フラグ | false |
| is_mythical | boolean | 幻フラグ | false |

### 2. **PokemonType (タイプマスタ)**
```ruby
# rails generate model PokemonType name_ja:string name_en:string color_code:string effectiveness:json
```

| カラム名 | 型 | 説明 | 例 |
|---------|----|----|-----|
| name_ja | string | 日本語タイプ名 | "でんき" |
| name_en | string | 英語タイプ名 | "Electric" |
| color_code | string | カラーコード | "#F7D02C" |
| **effectiveness** | **json** | **相性データ** | **{"こうかばつぐん":["みず","ひこう"], ...}** |

## 🔄 **JSON構造の例**

### **stats (種族値)**
```json
{
  "hp": 35,
  "attack": 55,
  "defense": 40,
  "sp_attack": 50,
  "sp_defense": 50,
  "speed": 90,
  "total": 320
}
```

### **abilities (特性)**
```json
[
  {"name": "せいでんき", "hidden": false},
  {"name": "ひらいしん", "hidden": true}
]
```

### **types (タイプ)**
```json
["でんき"]
```

## 📥 **JSONインポート設計**

### **JSONファイル配置**
```
lib/pokemon_data/
├── pokemon_species.json    # メインデータ
├── types.json             # タイプ相性
└── import_script.rb       # インポート処理
```

### **インポートRakeタスク**
```ruby
# lib/tasks/pokemon_import.rake
namespace :pokemon do
  desc "Import Pokemon data from JSON"
  task import_species: :environment do
    file_path = Rails.root.join('lib', 'pokemon_data', 'pokemon_species.json')
    pokemon_data = JSON.parse(File.read(file_path))
    
    pokemon_data.each do |data|
      PokemonSpecies.find_or_create_by(national_id: data['id']) do |pokemon|
        pokemon.name_ja = data['name']['ja']
        pokemon.name_en = data['name']['en']
        pokemon.types = data['types']
        pokemon.stats = data['stats']
        pokemon.abilities = data['abilities']
        pokemon.generation = data['generation']
        pokemon.category = data['category']
        pokemon.height = data['height']
        pokemon.weight = data['weight']
        pokemon.description = data['description']
        pokemon.image_url = data['image_url']
        pokemon.is_legendary = data['is_legendary'] || false
        pokemon.is_mythical = data['is_mythical'] || false
      end
    end
    
    puts "✅ #{pokemon_data.length} Pokemon species imported!"
  end
  
  task import_types: :environment do
    file_path = Rails.root.join('lib', 'pokemon_data', 'types.json')
    types_data = JSON.parse(File.read(file_path))
    
    types_data.each do |data|
      PokemonType.find_or_create_by(name_ja: data['name_ja']) do |type|
        type.name_en = data['name_en']
        type.color_code = data['color_code']
        type.effectiveness = data['effectiveness']
      end
    end
    
    puts "✅ #{types_data.length} Pokemon types imported!"
  end
  
  task import_all: [:import_types, :import_species] do
    puts "🎉 All Pokemon data imported successfully!"
  end
end
```

### 4. PokemonAbility (ポケモン-特性中間テーブル)
```ruby
# rails generate model PokemonAbility pokemon:references ability:references slot:integer is_hidden:boolean
```

| カラム名 | 型 | 説明 |
|---------|----|----|
| id | integer | 主キー |
| pokemon_id | integer | ポケモンID |
| ability_id | integer | 特性ID |
| slot | integer | 特性スロット |
| is_hidden | boolean | 隠れ特性フラグ |

### 5. Move (技)
```ruby
# rails generate model Move name:string type_name:string category:string power:integer accuracy:integer pp:integer priority:integer generation:integer description:text
```

| カラム名 | 型 | 説明 |
|---------|----|----|
| id | integer | 主キー |
| name | string | 技名 |
| type_name | string | 技タイプ |
| category | string | 分類（物理/特殊/変化）|
| power | integer | 威力 |
| accuracy | integer | 命中率 |
| pp | integer | PP |
| priority | integer | 優先度 |
| generation | integer | 登場世代 |
| description | text | 技説明 |

### 6. PokemonMove (ポケモン-技中間テーブル)
```ruby
# rails generate model PokemonMove pokemon:references move:references learn_method:string level:integer generation:integer
```

| カラム名 | 型 | 説明 |
|---------|----|----|
| id | integer | 主キー |
| pokemon_id | integer | ポケモンID |
| move_id | integer | 技ID |
| learn_method | string | 習得方法（level/tm/egg等）|
| level | integer | 習得レベル |
| generation | integer | 対象世代 |

## 🔗 リレーション設計

```ruby
# app/models/pokemon.rb
class Pokemon < ApplicationRecord
  has_many :pokemon_types, dependent: :destroy
  has_many :pokemon_abilities, dependent: :destroy
  has_many :abilities, through: :pokemon_abilities
  has_many :pokemon_moves, dependent: :destroy
  has_many :moves, through: :pokemon_moves
  
  # ナズロック用
  has_many :captured_pokemons, class_name: 'Pokemon', foreign_key: 'species_id'
  
  validates :name, presence: true
  validates :pokedex_number, presence: true, uniqueness: true
  
  scope :legendary, -> { where(is_legendary: true) }
  scope :mythical, -> { where(is_mythical: true) }
  scope :by_generation, ->(gen) { where(generation: gen) }
  
  def primary_type
    pokemon_types.where(slot: 1).first&.type_name
  end
  
  def secondary_type
    pokemon_types.where(slot: 2).first&.type_name
  end
  
  def type_names
    pokemon_types.order(:slot).pluck(:type_name)
  end
end

# app/models/pokemon_type.rb
class PokemonType < ApplicationRecord
  belongs_to :pokemon
  
  validates :type_name, presence: true
  validates :slot, presence: true, inclusion: { in: 1..2 }
  validates :pokemon_id, uniqueness: { scope: :slot }
end

# app/models/ability.rb
class Ability < ApplicationRecord
  has_many :pokemon_abilities, dependent: :destroy
  has_many :pokemons, through: :pokemon_abilities
  
  validates :name, presence: true, uniqueness: true
end

# app/models/pokemon_ability.rb
class PokemonAbility < ApplicationRecord
  belongs_to :pokemon
  belongs_to :ability
  
  validates :slot, presence: true
  validates :pokemon_id, uniqueness: { scope: :slot }
end

# app/models/move.rb
class Move < ApplicationRecord
  has_many :pokemon_moves, dependent: :destroy
  has_many :pokemons, through: :pokemon_moves
  
  validates :name, presence: true, uniqueness: true
  validates :category, inclusion: { in: %w[physical special status] }
end

# app/models/pokemon_move.rb
class PokemonMove < ApplicationRecord
  belongs_to :pokemon
  belongs_to :move
  
  validates :learn_method, presence: true
  validates :generation, presence: true
end
```

## 📈 データ投入戦略

### Phase 1: 基本ポケモンデータ
1. **pokemon.csv** から基本情報投入
2. **タイプ情報** の正規化
3. **画像URL** の追加

### Phase 2: 特性・技データ
1. **abilities.csv** から特性データ
2. **moves.csv** から技データ  
3. **関連付けデータ** の投入

### Phase 3: 拡張データ
1. **進化系情報**
2. **地方別図鑑**
3. **フォルム違い**

## 🛠️ 実装順序

### 1. 基本モデル作成
```bash
rails generate model Pokemon name:string pokedex_number:integer hp:integer attack:integer defense:integer special_attack:integer special_defense:integer speed:integer total_stats:integer generation:integer is_legendary:boolean is_mythical:boolean sprite_url:string

rails generate model PokemonType pokemon:references type_name:string slot:integer

rails generate model Ability name:string description:text generation:integer

rails generate model PokemonAbility pokemon:references ability:references slot:integer is_hidden:boolean
```

### 2. CSVインポーター作成
```ruby
# lib/tasks/import_pokemon.rake
namespace :pokemon do
  desc "Import Pokemon data from CSV"
  task import: :environment do
    # CSVファイルからデータ投入
  end
end
```

### 3. 図鑑コントローラー作成
```bash
rails generate controller Pokedex index show search
```

## 🎨 UI設計

### 図鑑一覧ページ
- ポケモン一覧（ページネーション）
- タイプ・世代でフィルタ
- 検索機能
- ソート機能

### 詳細ページ  
- 基本情報・種族値
- タイプ・特性
- 覚える技一覧
- 進化系情報

## 🔍 検索機能

```ruby
# app/models/pokemon.rb
scope :search, ->(query) {
  where("name ILIKE ?", "%#{query}%")
    .or(where(pokedex_number: query.to_i))
}

scope :by_type, ->(type) {
  joins(:pokemon_types).where(pokemon_types: { type_name: type })
}
```

この設計でどう？すごく拡張性があって、将来的にいろんな機能追加できそう✨
