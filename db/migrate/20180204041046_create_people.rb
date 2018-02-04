class CreatePeople < ActiveRecord::Migration[5.1]
  def change
    create_table :people do |t|
      t.string :name
      t.string :alternate_name
      t.string :email
      t.string :image
      t.string :telephone
      t.string :mobile
      t.address :address
      t.string :headline
      t.text :summary
      t.string :current_position
      t.string :linkedin_profile
      t.string :twitter_profile

      t.timestamps
    end
  end
end
