Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, :controllers => { :omniauth_callbacks => 'users/omniauth_callbacks' }
  resources :users

  root 'home#index'

  get '/lost_articles'  => 'home#lost_articles'
  get '/found_articles' => 'home#found_articles'

  resources :articles
end
