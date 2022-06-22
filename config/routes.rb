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
    resources :read_notifications, only: [:index, :create], path: "/notifications/read"
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

    namespace :conversations do
      resources :blocks, only: :index
    end

    resources :businesses, only: [] do
      resources :conversations, only: :index, controller: :business_conversations
      resources :invisiblizes, only: :create, module: :businesses
    end

    resources :developers, only: [] do
      resources :conversations, only: :index, controller: :developer_conversations
      resources :features, only: :create
      resources :invisiblizes, only: :create, module: :developers
    end
  end

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resource :auth, only: [:create, :destroy]
      resources :notification_tokens, only: :create
    end
  end

  namespace :stripe do
    resource :checkout, only: :create
    resource :portal, only: :show
  end

  namespace :turbo do
    namespace :ios do
      resource :path_configuration, only: :show
    end
  end

  get "/sitemap.xml.gz", to: redirect("#{Rails.configuration.sitemaps_host}sitemaps/sitemap.xml.gz"), as: :sitemap
  get "robots.:format" => "robots#index"

  authenticate :user, lambda { |user| SidekiqPolicy.new(user).visible? } do
    mount Sidekiq::Web => "/sidekiq"
  end
end
