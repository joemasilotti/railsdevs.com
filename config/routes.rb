Rails.application.routes.draw do
  devise_for :users

  resource :about, only: :show, controller: :about
  resource :home, only: :show
  resource :role, only: :new
  resources :businesses, only: %i[new create edit update]
  resources :developers, except: :destroy

  root to: "home#show"
end
