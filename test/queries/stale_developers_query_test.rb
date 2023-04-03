require "test_helper"

class StaleDevelopersQueryTest < ActiveSupport::TestCase
  include DevelopersHelper

  test ".stale_developers returns active developers who haven't updated their profile in 3 months" do
    travel_to(StaleDevelopersQuery::EARLIEST_TIME)
    stale_developer = create_developer
    travel_back

    records = StaleDevelopersQuery.new.stale_developers
    assert_includes records, stale_developer
  end

  test ".stale_developers ignores not_interested developers" do
    travel_to(StaleDevelopersQuery::EARLIEST_TIME)
    stale_developer = create_developer
    stale_developer.mark_as_stale_and_notify
    travel_back

    assert_empty StaleDevelopersQuery.new.stale_developers
  end

  test ".stale_developers ignores invisible developers" do
    travel_to(StaleDevelopersQuery::EARLIEST_TIME)
    developer = create_developer(search_status: nil)
    travel_back

    records = StaleDevelopersQuery.new.stale_developers
    assert_includes records, developer

    developer.search_status = :invisible
    developer.save(touch: false) # Don't update #updated_at.
    refute_includes StaleDevelopersQuery.new.stale_developers, developer
  end
end
