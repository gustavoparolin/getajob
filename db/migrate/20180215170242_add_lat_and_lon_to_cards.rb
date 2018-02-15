class AddLatAndLonToCards < ActiveRecord::Migration[5.1]
  def change
    add_column :cards, :latitude, :float
    add_column :cards, :longitude, :float
  end
end
