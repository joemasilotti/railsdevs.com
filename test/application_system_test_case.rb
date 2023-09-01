require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  include Devise::Test::IntegrationHelpers

  driver = ENV["HEADFUL"] ? :chrome : :headless_chrome
  driven_by :selenium, using: driver, screen_size: [1920, 1080]
end
