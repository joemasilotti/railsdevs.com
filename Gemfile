source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.2"

gem "rails", github: "rails/rails", branch: "main"

gem "cssbundling-rails"
gem "hotwire-rails", "~> 0.1.3"
gem "jsbundling-rails"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "sass-rails", ">= 6"
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
  gem "capybara"
end

# Point at main until Rails 7 changes are released.
gem "devise", github: "heartcombo/devise"

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem "aws-sdk-s3", "~> 1", require: false
gem "inline_svg", "~> 1.7"
gem "mailgun-ruby", "~> 1.2"
gem "pundit", "~> 2.1"
