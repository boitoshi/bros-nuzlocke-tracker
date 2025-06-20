class CreateBattleRecords < ActiveRecord::Migration[8.0]
  def change
    create_table :battle_records do |t|
      t.references :challenge, null: false, foreign_key: true
      t.references :boss_battle, null: true, foreign_key: true
      t.integer :battle_type, null: false, default: 0
      t.integer :result, null: false, default: 0
      t.datetime :battle_date, null: false
      t.string :location
      t.string :opponent_name, null: false
      t.json :opponent_data
      t.text :battle_notes
      t.integer :total_turns, default: 0
      t.integer :experience_gained, default: 0
      t.json :casualties
      t.references :mvp_pokemon, null: true, foreign_key: { to_table: :pokemons }
      t.integer :difficulty_rating, default: 3

      t.timestamps
    end
    
    add_index :battle_records, :battle_type
    add_index :battle_records, :result
    add_index :battle_records, :battle_date
  end
end
