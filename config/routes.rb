Rails.application.routes.draw do
  devise_for :users, controllers: {sessions: "users/sessions"}

  resources :developers, except: %i[destroy]

  root to: "developers#index"
end
