require "test_helper"

class HomeTest < ActionDispatch::IntegrationTest
  test "sees only available developer profile" do
    get root_path

    assert_select "h2", developers(:available).hero
    assert_select "h2", count: 1
  end
end
