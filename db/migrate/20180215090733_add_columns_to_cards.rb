class AddColumnsToCards < ActiveRecord::Migration[5.1]
  def change
    add_column :cards, :description, :text
    add_column :cards, :job_position, :string
    add_column :cards, :url, :string
    add_column :cards, :font, :string
    add_column :cards, :location, :string
    add_column :cards, :salary, :float
    add_column :cards, :salary_currency, :string, :default => 'CAD'
    add_column :cards, :salary_period, :string, :default => 'Annual'
    add_column :cards, :employment_type, :string
    add_column :cards, :work_hours, :string
    add_column :cards, :time_commute, :datetime
    add_column :cards, :distance_commute, :float
    add_column :cards, :resume_file, :string
    add_column :cards, :cover_letter, :text
    add_column :cards, :accept_remote, :boolean, :default => FALSE
    add_column :cards, :date_posted, :datetime
    add_column :cards, :due_date, :datetime
    add_column :cards, :education_requirements, :text
    add_column :cards, :language_requeriments, :text
    add_column :cards, :experience_requirements, :text
    add_column :cards, :responsabilities, :text
    add_column :cards, :qualifications, :text
    add_column :cards, :skills, :text
    add_column :cards, :incentive_compensation, :text
    add_column :cards, :benefits, :text
  end
end
