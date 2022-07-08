require "application_system_test_case"

class WebpTest < ApplicationSystemTestCase
  test "visiting the webp page displayes and image" do
    visit webp_path

    assert find("img")
  end
end
