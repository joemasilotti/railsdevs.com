require "application_system_test_case"

class FiltersTest < ApplicationSystemTestCase
  test "developers availability sort click adds sort param" do
    visit developers_path
    find(:css, "#sort button[type='button']").click
    find(:css, "#sort button[type='submit'][value='availability']").click

    assert_current_path(/sort=availability/)
  end

  test "developers newest sort click adds sort param" do
    visit developers_path
    click_sort_by_newset
    assert_current_path(/sort=newest/)
  end

  test "developers sort order is persisted with work preferences filters" do
    visit developers_path
    find(:css, "[name='include_not_interested']").set(true)
    click_sort_by_newset

    assert_current_path(/sort=newest/)
    assert_current_path(/include_not_interested=1/)
  end

  test "applying multiple filters to developers" do
    visit developers_path

    find(:css, "#sort button[type='button']").click
    find(:css, "#sort button[type='submit'][value='availability']").click

    assert_current_path(/sort=availability/)

    find(:css, "[name='include_not_interested']").set(true)
    find(:css, "input[type=submit]").click

    assert_current_path(/sort=availability/)
    assert_current_path(/include_not_interested=1/)

    click_sort_by_newset

    assert_current_path(/sort=newest/)
    assert_current_path(/include_not_interested=1/)
  end

  def click_sort_by_newset
    toggle_sort_dropdown
    find(:css, "#sort button[type='submit'][value='newest']").click
  end

  def toggle_sort_dropdown
    find(:css, "#sort button[type='button']").click
  end
end
