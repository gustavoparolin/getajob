class ChangeColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :boards, :title, :name
    rename_column :boards, :order, :position
    rename_column :lists, :title, :name
    rename_column :lists, :order, :position
  end
end
