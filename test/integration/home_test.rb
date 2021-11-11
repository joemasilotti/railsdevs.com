require "test_helper"

class HomeTest < ActionDispatch::IntegrationTest
  test "sees only available developer profile" do
    available = developers :available
    unavailable = developers :unavailable

    get root_path

    assert_select "h2", available.hero
    assert_select "h2", unavailable.hero, false
  end
end
