Rails.application.routes.draw do
  devise_for :users

  resource :about, only: :show, controller: :about
  resource :home, only: :show
  resource :role, only: :new
  resources :businesses, except: :destroy
  resources :conversations, only: %i[index show] do
    resources :messages, only: :create
    resource :block, only: %i[new create]
  end
  resources :developers, except: :destroy do
    resources :messages, only: %i[new create], controller: :cold_messages
  end

  namespace :admin do
    resources :conversations, only: :index
  end

  root to: "home#show"
end
