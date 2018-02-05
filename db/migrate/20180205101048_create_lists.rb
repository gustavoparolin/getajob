class CreateLists < ActiveRecord::Migration[5.1]
  def change
    create_table :lists do |t|
      t.string :title
      t.integer :order, default: 1
      t.string :background_color
      t.string :image
      t.boolean :status
      t.string :slug
      t.references :board, foreign_key: true

      t.timestamps
    end
    add_index :lists, :title
    add_index :lists, :slug
  end
end
