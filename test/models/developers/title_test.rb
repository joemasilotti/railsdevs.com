require "test_helper"

class Developers::TitleTest < ActiveSupport::TestCase
  test "displays role level when one is selected" do
    title = build_title(role_levels: [:junior])
    assert_equal title, "Hire junior Ruby on Rails developers"

    title = build_title(role_levels: [:junior, :senior])
    assert_equal title, "Hire Ruby on Rails developers"

    title = build_title(role_levels: [])
    assert_equal title, "Hire Ruby on Rails developers"
  end

  test "displays 'freelance' when only both contract role types are selected" do
    title = build_title(role_types: [:part_time_contract, :full_time_contract])
    assert_equal title, "Hire freelance Ruby on Rails developers"

    title = build_title(role_types: [:part_time_contract, :full_time_contract, :full_time_employment])
    assert_equal title, "Hire Ruby on Rails developers"

    title = build_title(role_types: [:part_time_contract])
    assert_equal title, "Hire Ruby on Rails developers"
  end

  test "displays country if one is selected" do
    title = build_title(countries: ["United States"])
    assert_equal title, "Hire Ruby on Rails developers in United States"

    title = build_title(countries: ["United States", "Canada"])
    assert_equal title, "Hire Ruby on Rails developers"

    title = build_title(countries: [])
    assert_equal title, "Hire Ruby on Rails developers"
  end

  test "role level comes before freelance (and country at the end)" do
    title = build_title(
      role_levels: [:senior],
      role_types: [:part_time_contract, :full_time_contract],
      countries: ["United States"]
    )
    assert_equal title, "Hire senior freelance Ruby on Rails developers in United States"
  end

  def build_title(query_options = {})
    query = DeveloperQuery.new(query_options)
    Developers::Title.new(query).title
  end
end
