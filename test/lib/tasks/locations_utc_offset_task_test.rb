require "test_helper"

class LocationsUTCOffsetTaskTest < ActiveSupport::TestCase
  include RakeTaskHelper

  test "sets locations.utc_offset for records with a time zone" do
    eastern = locations(:eastern)
    eastern.utc_offset = 0
    eastern.save!(validate: false)

    load_rake_tasks_once
    Rake::Task["locations:utc_offset"].invoke

    assert_equal(-18_000, locations(:eastern).reload.utc_offset)
  end
end
