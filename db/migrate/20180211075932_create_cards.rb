class CreateCards < ActiveRecord::Migration[5.1]
  def change
    create_table :cards do |t|
      t.string :name
      t.integer :position
      t.string :slug
      t.references :list, foreign_key: true

      t.timestamps
    end
    add_index :cards, :name
    add_index :cards, :slug
  end
end
