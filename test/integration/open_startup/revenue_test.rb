require "test_helper"

class OpenStartup::RevenueTest < ActionDispatch::IntegrationTest
  test "shows all revenue" do
    get open_startup_revenue_index_path
    assert_select "tr td", text: open_startup_revenue(:one).description
  end
end
