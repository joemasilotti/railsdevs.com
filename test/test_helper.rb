ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "capybara"

Dir[Rails.root.join("test/support/**/*.rb")].each { |f| require f }

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  setup do
    ActiveStorage::Current.url_options = {protocol: "https://", host: "example.com", port: nil}
  end

  teardown do
    ActiveStorage::Current.reset
  end
end

class ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
end

class ViewComponent::TestCase
  include FileTagsHelper
  include MetaTagsHelper
end

ActiveStorage::FixtureSet.file_fixture_path = File.expand_path("fixtures/files", __dir__)
