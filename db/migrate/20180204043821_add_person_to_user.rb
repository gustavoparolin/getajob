class AddPersonToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :person_id, :bigint
    add_index :users, :person_id, unique: true
  end
end
