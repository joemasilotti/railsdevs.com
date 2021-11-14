source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.2"

gem "rails", github: "rails/rails", branch: "main"

gem "cssbundling-rails", "~> 0.2"
gem "hotwire-rails", "~> 0.1"
gem "jsbundling-rails", "~> 0.1"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "sprockets-rails", "~> 3.3", require: "sprockets/railtie"
gem "view_component", "~> 2.42"

group :development, :test do
  gem "letter_opener_web"
  gem "pry-rails"
  gem "standard"
end

group :development do
  gem "listen", "~> 3.3"
end

group :test do
  gem "capybara", "~> 3.36"
end

# Point at main until Rails 7 changes are released.
gem "devise", github: "heartcombo/devise"

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem "aws-sdk-s3", "~> 1", require: false
gem "honeybadger", "~> 4.0"
gem "inline_svg", "~> 1.7"
gem "mailgun-ruby", "~> 1.2"
gem "noticed", "~> 1.4"
gem "pagy", "~> 5.2"
gem "pundit", "~> 2.1"
gem "redcarpet", "~> 2.3"
