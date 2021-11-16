Rails.application.routes.draw do
  get 'conversations/show'
  get 'conversations/index'
  devise_for :users

  resource :about, only: :show, controller: :about
  resource :home, only: :show
  resources :developers, except: :destroy
  resources :conversations, only: [:show, :index]

  root to: "home#show"
end
