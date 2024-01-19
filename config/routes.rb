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


  get '/payments/new_payment_form', to: 'payments#new_payment_form'
  post '/payments/new_payment', to: 'payments#new_payment'
  get '/payments/check_status/:code', to: 'payments#check_status'

  get '/payments/upload_csv', to: 'payments#upload_csv'

  ActiveAdmin.routes(self)


  namespace :api, defaults: { format: :json } do
    devise_for :users, controllers: {
      sessions: 'api/sessions'
    }
  end

  post '/api/users/login', to: 'api/sessions#login'
  post '/api/users/signup', to: 'api/sessions#signup'

  namespace :creators do
    resources :blogs, only: [:index] do
    end
  end

  resources :custom_login, only: [] do
    collection do
      post :generate_otp
      post :verify_otp
      get :with_otp
    end
  end

end
