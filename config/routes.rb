Rails.application.routes.draw do
  devise_for :users

  resource :home, only: %i[show]
  resources :developers, except: %i[destroy]

  root to: "home#show"
end
