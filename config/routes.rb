require "sidekiq/web"

Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :users

    resource :about, only: :show, controller: :about
    resource :conduct, only: :show
    resource :home, only: :show
    resource :pricing, only: :show, controller: :pricing
    resource :role, only: :new

    resources :businesses, except: :destroy

    # /notifications/read must come before /notifications/:id.
    resources :read_notifications, only: :index, path: "/notifications/read"
    resources :notifications, only: %i[index show]

    namespace :analytics do
      resources :events, only: :show
    end

    resources :conversations, only: %i[index show] do
      resources :messages, only: :create
      resource :block, only: %i[new create]
    end

    resources :developers, except: :destroy do
      resources :messages, only: %i[new create], controller: :cold_messages
    end

    namespace :open_startup, path: "/open" do
      resources :contributions, only: :index
      resources :expenses, only: :index
      resources :revenue, only: :index

      root to: "dashboard#show"
    end

    root to: "home#show"
  end

  namespace :admin do
    resources :conversations, only: :index
    resources :transactions, except: :show
  end

  namespace :stripe do
    resource :checkout, only: :create
    resource :portal, only: :show
  end

  get "/sitemap.xml.gz", to: redirect("#{Rails.configuration.sitemaps_host}sitemaps/sitemap.xml.gz"), as: :sitemap
  get "robots.:format" => "robots#index"

  authenticate :user, lambda { |user| SidekiqPolicy.new(user).visible? } do
    mount Sidekiq::Web => "/sidekiq"
  end
end
