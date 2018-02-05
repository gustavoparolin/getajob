Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  resources :boards
  resources :people
  match '/client/', to: "client#index", via: :all
  match '/client/*path', to: "client#index", via: :all

  root 'home#index'

  devise_for :users, controllers: {
    sessions: 'user/sessions'
  }

end
