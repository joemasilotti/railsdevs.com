require "test_helper"

class AboutTest < ActionDispatch::IntegrationTest
  test "renders both sections of markdown" do
    get about_path

    assert_select "li", "Empowering the developer"
    assert_select "h3", "Empowering the developer"
  end
end
