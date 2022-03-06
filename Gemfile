source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.0"

gem "rails", "~> 7.0"

gem "cssbundling-rails", "~> 1.0"
gem "hotwire-rails", "~> 0.1"
gem "jsbundling-rails", "~> 1.0"
gem "pg", "~> 1.1"
gem "puma", "~> 5.6"
gem "sprockets-rails", "~> 3.4"
gem "stimulus-rails", "~> 0.7"
gem "turbo-rails", "~> 1.0"
gem "view_component", "~> 2.49"

group :development, :test do
  gem "faker"
  gem "i18n-tasks"
  gem "letter_opener_web"
  gem "pry-rails"
  gem "standard"
end

group :development do
  # Point to GitHub until https://github.com/Shopify/erb-lint/pull/235 is released.
  gem "erb_lint", require: false, github: "Shopify/erb-lint"
  gem "hotwire-livereload"
  gem "listen", "~> 3.3"
  gem "redis"
end

group :test do
  gem "capybara", "~> 3.36"
  gem "minitest-reporters", "~> 1.5", require: false
  gem "minitest-reporters-pride_reporter", "~> 0.0.2", require: false
  gem "selenium-webdriver"
  gem "webdrivers"
end

gem "auto_html", "~> 2.1"
gem "aws-sdk-s3", "~> 1", require: false
gem "classy-yaml", "~> 0.7"
gem "devise", "~> 4.8.1"
gem "devise-i18n", "~> 1.10.1"
gem "fathom_api", "~> 0.1.2"
gem "geocoder", "~> 1.7.3"
gem "groupdate", "~> 6.0.1"
gem "honeybadger", "~> 4.0"
gem "inline_svg", "~> 1.7"
gem "mailgun-ruby", "~> 1.2"
gem "noticed", "~> 1.4"
gem "pagy", "~> 5.2"
gem "pay", "~> 3.0"
gem "pundit", "~> 2.1"
gem "rails-i18n", "~> 7.0"
gem "redcarpet", "~> 3.5"
gem "rexml", "~> 3.2", ">= 3.2.5"
gem "scout_apm", "~> 5.1"
gem "sidekiq", "~> 6.4"
gem "sitemap_generator", "~> 6.1"
gem "stripe", ">= 2.8", "< 6.0"
gem "timezone_finder", "~> 1.5.7"
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
