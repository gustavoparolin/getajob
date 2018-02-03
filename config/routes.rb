Rails.application.routes.draw do

  match '/client/', to: "client#index", via: :all
  match '/client/*path', to: "client#index", via: :all

  root 'home#index'

  devise_for :users, controllers: {
    sessions: 'user/sessions'
  }

end
