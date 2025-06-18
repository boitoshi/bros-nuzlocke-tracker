class CreateRules < ActiveRecord::Migration[8.0]
  def change
    create_table :rules do |t|
      t.references :challenge, null: false, foreign_key: true
      t.string :name, null: false
      t.text :description
      t.string :rule_type, null: false
      t.boolean :enabled, default: true
      t.string :default_value
      t.string :custom_value
      t.integer :sort_order, default: 0

      t.timestamps
    end

    add_index :rules, [ :challenge_id, :rule_type ]
    add_index :rules, [ :challenge_id, :enabled ]
  end
end
