class CreateBossBattles < ActiveRecord::Migration[8.0]
  def change
    create_table :boss_battles do |t|
      t.string :name, null: false
      t.string :boss_type, null: false
      t.string :game_title, null: false
      t.references :area, null: true, foreign_key: true
      t.integer :level
      t.text :description
      t.json :pokemon_data
      t.text :strategy_notes
      t.integer :difficulty, default: 1
      t.integer :order_index, default: 0

      t.timestamps
    end

    add_index :boss_battles, [:game_title, :boss_type]
    add_index :boss_battles, [:game_title, :order_index]
  end
end
