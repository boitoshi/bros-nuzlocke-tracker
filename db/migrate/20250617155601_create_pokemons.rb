class CreatePokemons < ActiveRecord::Migration[8.0]
  def change
    create_table :pokemons do |t|
      t.string :nickname
      t.string :species
      t.integer :level
      t.string :nature
      t.string :ability
      t.integer :status
      t.datetime :caught_at
      t.datetime :died_at
      t.text :experience
      t.boolean :in_party
      t.references :challenge, null: false, foreign_key: true
      t.bigint :area_id

      t.timestamps
    end
  end
end
