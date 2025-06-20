class CreateBattleParticipants < ActiveRecord::Migration[8.0]
  def change
    create_table :battle_participants do |t|
      t.references :battle_record, null: false, foreign_key: true
      t.references :pokemon, null: false, foreign_key: true
      t.integer :starting_level, null: false
      t.integer :ending_level, null: false
      t.integer :starting_hp, default: 0
      t.integer :ending_hp, default: 0
      t.integer :turns_active, default: 0
      t.integer :damage_dealt, default: 0
      t.integer :damage_taken, default: 0
      t.json :moves_used
      t.boolean :was_ko, default: false
      t.text :performance_notes

      t.timestamps
    end
    
    add_index :battle_participants, [:battle_record_id, :pokemon_id], 
              unique: true, name: 'index_battle_participants_unique'
    add_index :battle_participants, :was_ko
  end
end
