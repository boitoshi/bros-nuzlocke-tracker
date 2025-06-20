class AddTypeAndRoleToPokemon < ActiveRecord::Migration[8.0]
  def change
    add_column :pokemons, :primary_type, :string, null: false, default: 'normal'
    add_column :pokemons, :secondary_type, :string
    add_column :pokemons, :role, :integer, default: 0
    
    add_index :pokemons, :primary_type
    add_index :pokemons, :secondary_type
    add_index :pokemons, :role
  end
end
