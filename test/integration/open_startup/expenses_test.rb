require "test_helper"

class OpenStartup::ExpensesTest < ActionDispatch::IntegrationTest
  test "shows all expenses" do
    get open_startup_expenses_path

    assert_select "tr td", text: open_startup_expenses(:without_url).description
    assert_select "tr td" do
      assert_select "a[href=?]", open_startup_expenses(:with_url).url,
        text: open_startup_expenses(:with_url).description
    end
  end
end
