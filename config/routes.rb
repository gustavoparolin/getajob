Rails.application.routes.draw do

  root 'home#index'

  resources :boards do
    resources :lists, shallow: true, only: [:create, :destroy, :update] do
      resources :cards, shallow: true, only: [:create, :destroy, :update] do
        resources :notes, shallow: true, only: [:create, :destroy, :update]
        resources :tasks, shallow: true, only: [:create, :destroy, :update]
      end
    end
  end
  resources :people

  devise_for :users, controllers: {
    sessions: 'user/sessions'
  }
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  match '/client/', to: "client#index", via: :all
  match '/client/*path', to: "client#index", via: :all

end
