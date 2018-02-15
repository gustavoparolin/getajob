Rails.application.routes.draw do
  resources :about, only: [:index]
  
  resources :lists, only: [] do
    member do
      patch :move
    end
  end
  resources :cards, only: [:create, :update] do
    member do
      patch :move
    end
  end
  resources :boards do
    resources :lists, shallow: true, only: [:create, :destroy] do
      resources :cards, shallow: true, only: [:destroy] do
        # resources :notes, shallow: true, only: [:create, :destroy, :update]
        # resources :tasks, shallow: true, only: [:create, :destroy, :update]
      end
    end
  end
  resources :people

  devise_scope :user do
    root to: "devise/sessions#new"
  end
  devise_for :users, controllers: {
    sessions: 'user/sessions',
    omniauth_callbacks: 'user/omniauth_callbacks'
  }
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  match '/client/', to: "client#index", via: :all
  match '/client/*path', to: "client#index", via: :all

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :boards do
        resources :lists, only: [:create, :destroy, :update]
      end
      resources :users, only: [:index, :show,:create,:destroy]
      resources :tokens, only: [:create]
    end
  end
end
