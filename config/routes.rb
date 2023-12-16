Rails.application.routes.draw do
  get 'collaborated_colleges/index'
  get 'contact_uss/index'
  get 'profiles/index'

  ActiveAdmin.routes(self)
  devise_for :users, class_name: 'User'
  
  # Root route to the ArticlesController#index action
  root 'articles#index'
  # Route for the ArticlesController#index action accessible at /articles
  get 'articles', to: 'articles#index'

  resources :students, only: [:index]

  # colleges
  namespace :colleges do
    get 'dashboard', to: 'dashboard#index'
  end
  get '/contact_us', to: 'contact_uss#index', as: 'contact_uss'
  resources :collaborated_colleges, only: [:index]

  resources :raise_an_issues, only: [:index]
  get 'raise_an_issues', to: 'raise_an_issues#index'
  get 'raise_an_issues/:id', to: 'raise_an_issues#show'
  get 'guidelines/index', to: 'guidelines#index', as: 'guidelines'
  get 'rewards/index', to: 'rewards#index', as: 'rewards'
  get 'sparkxs/index', to: 'sparkxs#index', as: 'sparkxs'

  post 'raise_an_issues/save_report', to: 'raise_an_issues#save_report', as: 'raise_an_issues_save_report'

  
  resources :profiles, only: [:index]

  resources :question_banks, only: [:index]

end