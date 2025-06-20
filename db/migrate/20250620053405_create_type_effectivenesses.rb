class CreateTypeEffectivenesses < ActiveRecord::Migration[8.0]
  def change
    create_table :type_effectivenesses do |t|
      t.string :attacking_type, null: false
      t.string :defending_type, null: false
      t.decimal :effectiveness, precision: 3, scale: 2, null: false

      t.timestamps
    end

    add_index :type_effectivenesses, [:attacking_type, :defending_type], unique: true
    add_index :type_effectivenesses, :attacking_type
    add_index :type_effectivenesses, :defending_type
  end
end
