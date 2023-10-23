Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: 'home#index'
  get "/home", to: "home#home"
  post 'call_logs/update_details', to: 'api/call_logs#update_details'
  ActiveAdmin.routes(self)


  namespace :api, defaults: { format: :json } do
    devise_for :users, controllers: {
      sessions: 'api/sessions'
    }

    # Other API routes...
  end


  
end
