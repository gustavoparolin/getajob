class ChangeDefaultColorTo999999 < ActiveRecord::Migration[5.1]
  def change
    change_column :boards, :background_color, :string, :default => '#999999'
    change_column :lists, :background_color, :string, :default => '#999999'
  end
end
