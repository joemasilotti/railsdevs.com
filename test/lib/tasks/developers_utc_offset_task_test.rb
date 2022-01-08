require "test_helper"

class DevelopersUtcOffsetTaskTest < ActiveSupport::TestCase
  test "sets developers.utc_offset for records with a time zone" do
    Railsdevs::Application.load_tasks
    Rake::Task["developers:utc_offset"].invoke

    assert_equal(-18_000, developers(:available).utc_offset)
    assert_equal(-28_800, developers(:unavailable).utc_offset)
    assert_nil developers(:with_conversation).utc_offset
  end
end
