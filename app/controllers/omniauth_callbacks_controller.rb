class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def index
    oauth_data = request.env['omniauth.auth']
    # render json: oauth_data

    user = User.find_by_oauth(oauth_data)
    user ||= User.create_from_oauth(oauth_data)
    if user.valid?
      session[:user_id] = user.id
      redirect_to root_path, notice: "You're signed in with LinkedIn"
    else
      redirect_to root_path, alert: user.errors.full_messages.join(", ")
    end
  end
end
