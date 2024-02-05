Rails.application.routes.draw do
  resources :member_activities
  resources :member_events
  resources :activity_types
  resources :activities
  resources :events
  resources :users
  resources :platoons

  # Defines the root path route ("/")
  # root "articles#index"
end
