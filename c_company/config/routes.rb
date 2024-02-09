Rails.application.routes.draw do
  resources :member_activities
  resources :member_events
  resources :activity_types
  resources :activities
  resources :events
  resources :users
  resources :platoons

  get '/auth/:provider/callback', to: 'sessions#create'
  # Defines the root path route ("/")
  root "sessions#new"
end
