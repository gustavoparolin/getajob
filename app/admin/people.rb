ActiveAdmin.register Person do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :name, :alternate_name, :email, :image, :telephone, :mobile, :headline, :summary, :current_position, :linkedin_profile, :twitter_profile, :address_formatted_address, :address_street_number, :address_street_name, :address_street, :address_city, :address_zip_code, :address_department, :address_department_code, :address_state, :address_state_code, :address_country_code, :address_country, :address_lat, :address_lng, :slug
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
  index do
    selectable_column
    id_column
    column :name
    column :email
    column :address_formatted_address
    column :created_at
    actions
  end
  
  controller do
    def find_resource
      scoped_collection.friendly.find(params[:id])
    end
  end

end
