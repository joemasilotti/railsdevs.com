source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.2"

gem "rails", github: "rails/rails", branch: "main"

gem "cssbundling-rails"
gem "jsbundling-rails"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "sass-rails", ">= 6"
gem "image_processing", "~> 1.12"
gem "active_storage_validations", "~>0.9"

group :development, :test do
  gem "letter_opener_web"
  gem "pry-rails"
  gem "standard"
end

group :development do
  gem "listen", "~> 3.3"
end

# Point at main until Rails 7 changes are released.
gem "devise", github: "heartcombo/devise"

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
