class CreateMilestones < ActiveRecord::Migration[8.0]
  def change
    create_table :milestones do |t|
      t.references :challenge, null: false, foreign_key: true
      t.string :name, null: false
      t.string :milestone_type, null: false
      t.text :description
      t.datetime :completed_at
      t.integer :order_index, default: 0
      t.string :game_area
      t.boolean :is_required, default: true
      t.json :completion_data

      t.timestamps
    end

    add_index :milestones, [:challenge_id, :milestone_type]
    add_index :milestones, [:challenge_id, :order_index]
    add_index :milestones, :completed_at
  end
end
