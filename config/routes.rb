Rails.application.routes.draw do
  devise_for :users

  resources :developers, except: %i[destroy] do
    resources :links, only: %i[show], param: :field
  end

  root to: "developers#index"
end
