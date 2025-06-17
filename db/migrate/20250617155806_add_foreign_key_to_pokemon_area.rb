class AddForeignKeyToPokemonArea < ActiveRecord::Migration[8.0]
  def change
    add_foreign_key :pokemons, :areas, on_delete: :nullify
    add_index :pokemons, :area_id
  end
end
