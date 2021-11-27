Rails.application.routes.draw do
  devise_for :users

  resource :about, only: :show, controller: :about
  resource :home, only: :show
  resource :role, only: :new
  resources :businesses, except: :destroy
  resources :developers, except: :destroy

  root to: "home#show"
end
