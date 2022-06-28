require "test_helper"

class Developers::QueryPathTest < ActiveSupport::TestCase
  test "generates unique URL paths for combinations of role levels, location, and freelance" do
    paths = Developers::QueryPath.all

    expected_path_count = (role_level_combinations * freelance_or_not) +
      (role_level_by_location_combinations * freelance_or_not) +
      (location_combinations * freelance_or_not)

    assert_equal expected_path_count, paths.count
    assert paths.uniq
  end

  def role_level_combinations
    RoleLevel::TYPES.count
  end

  def location_combinations
    Location.top_countries.count
  end

  def role_level_by_location_combinations
    role_level_combinations * location_combinations
  end

  def freelance_or_not
    2
  end
end
