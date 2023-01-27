ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "minitest/autorun"
require "minitest/mock"
require "rails/test_help"
require "capybara"
require "minitest/reporters"
require "minitest/reporters/pride_reporter"
require "webmock/minitest"

Dir[Rails.root.join("test/support/**/*.rb")].each { |f| require f }

unless ENV["RM_INFO"] # Disable reporters for RubyMine
  options = (ENV["REPORTER"].to_s.downcase == "slow") ? {fast_fail: true, slow_count: 5} : {}
  Minitest::Reporters.use!([Minitest::Reporters::PrideReporter.new(options)])
end

WebMock.disable_net_connect!({
  allow_localhost: true,
  allow: "chromedriver.storage.googleapis.com"
})

class ActiveSupport::TestCase
  include GeocoderHelper

  EASTERN_UTC_OFFSET = -5 * 60 * 60
  PACIFIC_UTC_OFFSET = -8 * 60 * 60

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

  def default_url_options
    Rails.application.routes.default_url_options
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
