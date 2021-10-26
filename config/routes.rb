Rails.application.routes.draw do
  root "developers#index"

  resources :developers, only: %i[index new create show]
end
