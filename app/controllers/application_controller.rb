class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |person_params|
      person_params.permit({person_attributes: [:name]}, :email, :role, :api_key, :password, :password_confirmation, :slug, :image)
    end
  end

  private
  def authenticate_user!
    unless user_signed_in?
      redirect_to new_user_session_path, alert: 'You must sign in or sign up first!'
    end
  end


end
