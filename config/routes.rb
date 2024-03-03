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

  get '/analytics/analytics_logs', to: 'analytics#analytics_logs'

  get '/analytics/platoons/:platoon_id', to: 'analytics#platoon_analytics', as: 'platoon_analytics'

  # Defines the root path route ("/")
  root "home#index"
end

