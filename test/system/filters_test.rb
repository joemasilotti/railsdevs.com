require "application_system_test_case"

class FiltersTest < ApplicationSystemTestCase
  test "developers availability sort click adds sort param" do
    visit developers_path
    find(:css, "#sort button[type='button']").click
    find(:css, "#sort button[type='submit'][value='availability']").click

    assert_current_path developers_path(sort: :availability)
  end

  test "developers newest sort click adds sort param" do
    visit developers_path
    find(:css, "#sort button[type='button']").click
    find(:css, "#sort button[type='submit'][value='newest']").click

    assert_current_path developers_path(sort: :newest)
  end

  test "developers sort order is persisted with work preferences filters" do
    visit developers_path
    find(:css, "#desktop-work-preferences-filters button[type='button']").click
    find(:css, "[name='include_not_interested']").set(true)
    find(:css, "#desktop-work-preferences-filters button[name='sort']").click

    assert_current_path developers_path(sort: :newest, include_not_interested: 1)
  end

  test "applying multiple filters to developers" do
    visit developers_path

    find(:css, "#sort button[type='button']").click
    find(:css, "#sort button[type='submit'][value='availability']").click

    assert_current_path developers_path(sort: :availability)

    find(:css, "#desktop-work-preferences-filters button[type='button']").click
    find(:css, "[name='include_not_interested']").set(true)
    find(:css, "#desktop-work-preferences-filters button[name='sort']").click

    assert_current_path developers_path(sort: :availability, include_not_interested: 1)

    find(:css, "#sort button[type='button']").click
    find(:css, "#sort button[type='submit'][value='newest']").click

    assert_current_path developers_path(sort: :newest, include_not_interested: 1)
  end
end
