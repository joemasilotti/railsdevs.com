Rails.application.routes.draw do
  devise_for :users

  resources :developers, except: %i[destroy]

  root to: "developers#index"
end
