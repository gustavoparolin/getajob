class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |person_params|
      person_params.permit({person_attributes: [:name]}, :email, :password, :password_confirmation)
    end
  end


end
