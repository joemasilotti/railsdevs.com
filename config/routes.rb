Rails.application.routes.draw do
  root "developers#index"

  resources :developers, except: %i[destory]
end
