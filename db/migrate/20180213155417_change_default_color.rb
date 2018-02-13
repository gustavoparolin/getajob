class ChangeDefaultColor < ActiveRecord::Migration[5.1]
  def change
    change_column :boards, :background_color, :string, :default => 'grey'
    change_column :boards, :status, :boolean, :default => true
    change_column :lists, :background_color, :string, :default => 'grey'
    change_column :lists, :status, :boolean, :default => true
  end
end
