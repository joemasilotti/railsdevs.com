require_relative "boot"
require_relative "subscriptions"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Railsdevs
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.2

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Compress HTML output with gzip.
    config.middleware.use Rack::Deflater

    # Don't generate system test files.
    config.generators.system_tests = nil

    # Load custom configuration.
    config.always_remember_me = true
    config.analytics = config_for(:analytics)
    config.deliver_celebration_promotion_after = nil
    config.developer_response_grace_period = 12.hours
    config.emails = config_for(:emails)
    config.fathom = config_for(:fathom)
    config.plans = config_for(:plans)
    config.sitemaps_host = "https://#{Rails.application.credentials.dig(:aws, :sitemaps_bucket)}.s3.#{Rails.application.credentials.dig(:aws, :region)}.amazonaws.com/"
    config.testimonials = config_for(:testimonials)
    config.upload_sitemap = false

    # Run background jobs via sidekiq.
    config.active_job.queue_adapter = :sidekiq

    # Search nested folders in config/locales for better organization
    config.i18n.load_path += Dir[Rails.root.join("config", "locales", "**", "*.{rb,yml}")]

    # Permitted locales available for the application
    config.i18n.available_locales = [:en, :fr, :es, :"zh-TW", :"zh-CN", :"pt-BR"]

    # Set default locale
    config.i18n.default_locale = :en

    # Use default language as fallback if translation is missing
    config.i18n.fallbacks = true
  end
end
