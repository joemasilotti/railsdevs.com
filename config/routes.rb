require "sidekiq/web"

Rails.application.routes.draw do
  devise_for :users

  resource :home, only: :show
  resource :about, only: :show, controller: :about
  resource :conduct, only: :show
  resource :pricing, only: :show, controller: :pricing
  resource :role, only: :new
  resources :businesses, except: :destroy
  resources :conversations, only: %i[index show] do
    resources :messages, only: :create
    resource :block, only: %i[new create]
  end
  resources :developers, except: :destroy do
    resources :messages, only: %i[new create], controller: :cold_messages
  end

  namespace :stripe do
    resource :checkout, only: :show
  end

  namespace :admin do
    resources :conversations, only: :index
  end

  root to: "home#show"

  get "robots.:format" => "robots#index"
  get "/sitemap.xml.gz", to: redirect("#{Rails.configuration.sitemaps_host}sitemaps/sitemap.xml.gz"), as: :sitemap

  authenticate :user, lambda { |user| SidekiqPolicy.new(user).visible? } do
    mount Sidekiq::Web => "/sidekiq"
  end
end
