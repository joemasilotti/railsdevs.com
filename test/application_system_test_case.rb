require "test_helper"
require "webdrivers"

Capybara.register_driver :headless_chrome do |app|
  options = ::Selenium::WebDriver::Chrome::Options.new
  options.add_argument("--headless") unless ActiveModel::Type::Boolean.new.cast(ENV["HEADFUL"])
  options.add_argument("--window-size=1920,1080")

  client = Selenium::WebDriver::Remote::Http::Default.new
  client.read_timeout = 240

  Capybara::Selenium::Driver.new(app, browser: :chrome, capabilities: [options], http_client: client)
end

Capybara.javascript_driver = :headless_chrome

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :headless_chrome

  private

  def login_as(user)
    visit new_user_session_path
    fill_in "E-mail", with: user.email
    fill_in "Password", with: "password"

    click_button "Sign in"
  end
end
