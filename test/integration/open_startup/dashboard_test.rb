require "test_helper"

class OpenStartup::DashboardTest < ActionDispatch::IntegrationTest
  test "shows MRR, contributions, and visitors" do
    get open_startup_root_path

    assert_select "dd", "$1,000"
    assert_select "dd", "$15"
    assert_select "dd", "5 K"
  end

  test "shows monthly balances" do
    get open_startup_root_path

    jan = open_startup_monthly_balances(:january)
    jan_profit = jan.revenue - jan.expenses - jan.contributions
    assert_select "tr" do
      assert_select "td", text: "January 2022"
      assert_select "td", text: "$#{jan_profit.to_i}"
    end

    feb = open_startup_monthly_balances(:february)
    feb_profit = feb.revenue - feb.expenses - feb.contributions
    assert_select "tr" do
      assert_select "td", text: "February 2022"
      assert_select "td", text: "$#{feb_profit.to_i}"
    end
  end
end
