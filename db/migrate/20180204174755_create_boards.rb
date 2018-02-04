class CreateBoards < ActiveRecord::Migration[5.1]
  def change
    create_table :boards do |t|
      t.string :title
      t.string :background_color
      t.string :background_image
      t.boolean :status
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
