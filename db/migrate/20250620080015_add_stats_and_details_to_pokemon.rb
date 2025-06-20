class AddStatsAndDetailsToPokemon < ActiveRecord::Migration[8.0]
  def change
    # Individual Values (IVs) - 個体値 (0-31)
    add_column :pokemons, :hp_iv, :integer, default: 0, null: false
    add_column :pokemons, :attack_iv, :integer, default: 0, null: false
    add_column :pokemons, :defense_iv, :integer, default: 0, null: false
    add_column :pokemons, :special_attack_iv, :integer, default: 0, null: false
    add_column :pokemons, :special_defense_iv, :integer, default: 0, null: false
    add_column :pokemons, :speed_iv, :integer, default: 0, null: false
    
    # Effort Values (EVs) - 努力値 (0-252, 合計最大510)
    add_column :pokemons, :hp_ev, :integer, default: 0, null: false
    add_column :pokemons, :attack_ev, :integer, default: 0, null: false
    add_column :pokemons, :defense_ev, :integer, default: 0, null: false
    add_column :pokemons, :special_attack_ev, :integer, default: 0, null: false
    add_column :pokemons, :special_defense_ev, :integer, default: 0, null: false
    add_column :pokemons, :speed_ev, :integer, default: 0, null: false
    
    # Additional details
    add_column :pokemons, :gender, :string, limit: 10
    add_column :pokemons, :notes, :text
  end
end
