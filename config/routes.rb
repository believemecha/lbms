Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: 'dashboard#index'
  get "/home", to: "home#home"
  get "/india", to: "home#india"

  post 'call_logs/update_details', to: 'api/call_logs#update_details'
  post 'call_logs/sync_logs', to: 'api/call_logs#sync_logs'

  get '/dashboard/logs', to: 'dashboard#logs', as: 'dashboard_logs'
  get '/dashboard', to: 'dashboard#index', as: 'dashboard_index'
  get '/dashboard/log_detail/:id', to: 'dashboard#log_detail'


  ##Partners
  get '/partner/dashboard', to: 'partners/dashboard#index'


  # get





  ActiveAdmin.routes(self)


  namespace :api, defaults: { format: :json } do
    devise_for :users, controllers: {
      sessions: 'api/sessions'
    }

  end

  post '/api/users/login', to: 'api/sessions#login'
  post '/api/users/signup', to: 'api/sessions#signup'


  
end
