class AddOrderToBoard < ActiveRecord::Migration[5.1]
  def change
    add_column :boards, :order, :integer, default: 1
  end
end
