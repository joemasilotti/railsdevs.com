require "test_helper"

class AboutTest < ActionDispatch::IntegrationTest
  test "renders both sections of markdown" do
    get about_path

    assert_select "h3", "Watch this video"
    assert_select "h3", "Creating a safe, inclusive environment"
  end
end
