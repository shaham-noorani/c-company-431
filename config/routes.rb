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
  resources :activities do
    get 'reassign', on: :member
    post 'assign_to_platoon', on: :member
    post 'assign_to_user', on: :member
    post 'assign_member/:activity_id', to: 'activities#assign_member', as: 'assign_member'
  end
  resources :events
  resources :users
  resources :platoons

  get '/auth/:provider/callback', to: 'sessions#create'

  get 'analytics', to: 'analytics#index'

  get '/activities/assign_member/:activity_id', to: 'activities#assign_member', as: 'assign_member'

  # Defines the root path route ("/")
  root "home#index"
end

