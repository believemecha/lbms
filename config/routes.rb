Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: 'dashboard#index'
  get "/home", to: "home#home"
  post 'call_logs/update_details', to: 'api/call_logs#update_details'
  post 'call_logs/sync_logs', to: 'api/call_logs#sync_logs'

  get '/dashboard/logs', to: 'dashboard#logs', as: 'dashboard_logs'
  get '/dashboard', to: 'dashboard#index', as: 'dashboard_index'

  ActiveAdmin.routes(self)


  namespace :api, defaults: { format: :json } do
    devise_for :users, controllers: {
      sessions: 'api/sessions'
    }

    # Other API routes...
  end


  
end
