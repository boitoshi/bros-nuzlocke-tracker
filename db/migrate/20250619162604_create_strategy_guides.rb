class CreateStrategyGuides < ActiveRecord::Migration[8.0]
  def change
    create_table :strategy_guides do |t|
      t.string :title, null: false
      t.string :guide_type, null: false
      t.string :game_title, null: false
      t.references :target_boss, null: true, foreign_key: { to_table: :boss_battles }
      t.text :content, null: false
      t.string :tags
      t.integer :difficulty, default: 1
      t.string :author
      t.boolean :is_public, default: true
      t.integer :views_count, default: 0
      t.integer :likes_count, default: 0

      t.timestamps
    end

    add_index :strategy_guides, [:game_title, :guide_type]
    add_index :strategy_guides, [:guide_type, :difficulty]
    add_index :strategy_guides, :is_public
  end
end
