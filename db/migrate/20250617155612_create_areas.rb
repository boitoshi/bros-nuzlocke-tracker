class CreateAreas < ActiveRecord::Migration[8.0]
  def change
    create_table :areas do |t|
      t.string :name
      t.string :area_type
      t.string :game_title
      t.integer :order_index

      t.timestamps
    end
  end
end
