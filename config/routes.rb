Rails.application.routes.draw do
  devise_for :users

  resource :about, only: :show, controller: :about
  resource :home, only: :show
  resources :developers, except: :destroy

  root to: "home#show"
end
