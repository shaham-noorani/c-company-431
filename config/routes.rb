Rails.application.routes.draw do
  # resources :member_activities do
  #   member do
  #     patch :mark_as_complete
  #   end
  # end
  resources :member_activities do
    collection do
      get :completed  
    end
    member do
      patch :mark_as_complete
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  get '/logout', to: 'sessions#destroy', as: 'logout'
  resources :helps, only: [:index]
  resources :member_events
  resources :activity_types
  resources :activities do
    get 'reassign', on: :member
    post 'assign_to_platoon', on: :member
    post 'assign_to_user', on: :member
    post '/another_function', to: 'cont#another_function', as: 'another_function'
    post '/platoon_assignment', to: 'cont#platoon_assignment', as: 'platoon_assignment'

    post 'assign_member/:activity_id', to: 'activities#assign_member', as: 'assign_member'
    post 'assign_platoon/:activity_id', to: 'activities#assign_platoon', as: 'assign_platoon'
  end

  resources :events
  resources :users
  resources :platoons
  get '/auth/:provider/callback', to: 'sessions#create'

  get 'analytics', to: 'analytics#index'
  get 'my_platoon', to: 'platoons#my_platoon'

  get '/activities/assign_member/:activity_id', to: 'activities#assign_member', as: 'assign_member'

  get '/activities/assign_platoon/:activity_id', to: 'activities#assign_platoon', as: 'assign_platoon'

  post '/another_function', to: 'activities#another_function', as: 'another_function'
  post '/another_function2', to: 'activities#another_function2', as: 'another_function2'

  post '/platoon_assignment', to: 'activities#platoon_assignment', as: 'platoon_assignment'

  get '/analytics/analytics_logs', to: 'analytics#analytics_logs', as: 'analytics_logs'

  get '/analytics/platoons/:platoon_id', to: 'analytics#platoon_analytics', as: 'platoon_analytics'

  get '/analytics/logs/:platoon_id', to: 'analytics#platoon_logs', as: 'platoon_logs'

  # Defines the root path route ("/")
  root "home#index"
end

