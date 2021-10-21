Rails.application.routes.draw do
  root "home#show"

  resource :home, only: :show
end
