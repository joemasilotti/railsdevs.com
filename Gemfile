source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.2"

gem "rails", "~> 7.0"

gem "cssbundling-rails", "~> 1.0"
gem "hotwire-rails", "~> 0.1"
gem "jsbundling-rails", "~> 1.0"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "sprockets-rails", "~> 3.4"
gem "stimulus-rails", "~> 0.7"
gem "turbo-rails", "~> 0.9"
gem "view_component", "~> 2.46"

group :development, :test do
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
end

gem "aws-sdk-s3", "~> 1", require: false
gem "classy-yaml", "~> 0.7"
gem "devise", "~> 4.8.1"
gem "honeybadger", "~> 4.0"
gem "inline_svg", "~> 1.7"
gem "mailgun-ruby", "~> 1.2"
gem "noticed", "~> 1.4"
gem "pagy", "~> 5.2"
gem "pay", "~> 3.0"
gem "pundit", "~> 2.1"
gem "redcarpet", "~> 3.5"
gem "sidekiq", "~> 6.3"
gem "stripe", ">= 2.8", "< 6.0"

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
