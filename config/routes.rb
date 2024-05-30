Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: 'dashboard#index'
  get "/home", to: "home#home"
  get "/india", to: "home#india"
  post "/webhook", to: "home#webhook"
  get "/emails", to: "home#emails"
  get "/abc", to: "home#abc"



  post 'call_logs/update_details', to: 'api/call_logs#update_details'
  post 'call_logs/sync_logs', to: 'api/call_logs#sync_logs'

  get '/dashboard/logs', to: 'dashboard#logs', as: 'dashboard_logs'
  get '/dashboard', to: 'dashboard#index', as: 'dashboard_index'
  get '/dashboard/log_detail/:id', to: 'dashboard#log_detail'

  get '/status', to: 'dashboard#update_status'
  get '/ai_magic/:code', to: 'magic_links#check_link'
  get '/ring', to: 'magic_links#ring_user'

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

  post '/api/users/request_reset_password', to: 'api/sessions#request_reset_password'
  post '/api/users//verify_reset_password', to: 'api/sessions#verify_reset_password'
  post '/api/users//update_profile', to: 'api/sessions#update_profile'

  namespace :creators do
    resources :blogs, only: [:index,:show,:edit] do
      collection do
        get :new_blog
        post :make_creation
      end
    end
  end

  resources :custom_login, only: [] do
    collection do
      post :generate_otp
      post :verify_otp
      get :with_otp
    end
  end

  namespace :develop, only: [:index] do
    resources :dashboard do 
      collection do
        get :stats
      end
    end
    resources :schools, only: [:index,:new] do 
      collection do
        post :create_new
      end
    end
  end

  resources :gpt, only: [:index] do
    collection do
      post :generate_response
      get :list_prompts
      get :chat
    end
  end

end
