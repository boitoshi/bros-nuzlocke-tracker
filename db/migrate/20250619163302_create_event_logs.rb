class CreateEventLogs < ActiveRecord::Migration[8.0]
  def change
    create_table :event_logs do |t|
      t.references :challenge, null: false, foreign_key: true
      t.string :event_type, null: false
      t.string :title, null: false
      t.text :description
      t.json :event_data
      t.datetime :occurred_at, null: false
      t.references :pokemon, null: true, foreign_key: true
      t.string :location
      t.integer :importance, default: 1

      t.timestamps
    end

    add_index :event_logs, [:challenge_id, :event_type]
    add_index :event_logs, [:challenge_id, :occurred_at]
    add_index :event_logs, :occurred_at
  end
end
