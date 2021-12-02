Rails.application.routes.draw do
  devise_for :users

  resource :about, only: :show, controller: :about
  resource :home, only: :show
  resource :role, only: :new
  resources :businesses, only: %i[new create edit update]
  resources :conversations, only: :index

  resources :developers, except: :destroy do
    resource :conversation, only: :show
    resources :messages, only: %i[new create]
  end

  root to: "home#show"
end
