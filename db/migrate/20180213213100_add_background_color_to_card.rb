class AddBackgroundColorToCard < ActiveRecord::Migration[5.1]
  def change
    add_column :cards, :background_color, :string, :default => '#999999'
    add_column :cards, :status, :boolean, :default => true
  end
end
