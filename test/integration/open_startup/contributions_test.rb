require "test_helper"

class OpenStartup::ContributionsTest < ActionDispatch::IntegrationTest
  test "shows community and CO2 removal contribution totals" do
    get open_startup_contributions_path
    assert_select "dd", text: "$100"
    assert_select "dd", text: "$7"
  end

  test "shows all contributions" do
    get open_startup_contributions_path

    assert_select "tr td", text: open_startup_contributions(:without_url).description
    assert_select "tr td" do
      assert_select "a[href=?]", open_startup_contributions(:with_url).url,
        text: open_startup_contributions(:with_url).description
    end
  end
end
