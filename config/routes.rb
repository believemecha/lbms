Rails.application.routes.draw do

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
end