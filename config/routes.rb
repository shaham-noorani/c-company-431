Rails.application.routes.draw do
  resources :member_activities do
    member do
      get :mark_complete
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  get '/logout', to: 'sessions#destroy', as: 'logout'
  resources :member_events
  resources :activity_types
  resources :activities
  resources :events
  resources :users
  resources :platoons

  get '/auth/:provider/callback', to: 'sessions#create'

  get 'analytics', to: 'analytics#index'

  # Defines the root path route ("/")
  root "home#index"
end

