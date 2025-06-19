class CreatePokemonSpecies < ActiveRecord::Migration[8.0]
  def change
    create_table :pokemon_species do |t|
      t.integer :national_id, null: false, comment: '図鑑番号'
      t.string :name_ja, null: false, comment: '日本語名'
      t.string :name_en, comment: '英語名'
      t.string :name_kana, comment: 'カタカナ名'
      t.json :data, comment: 'JSON形式のポケモンデータ'

      t.timestamps
    end

    add_index :pokemon_species, :national_id, unique: true
    add_index :pokemon_species, :name_ja
    add_index :pokemon_species, :name_en
  end
end
