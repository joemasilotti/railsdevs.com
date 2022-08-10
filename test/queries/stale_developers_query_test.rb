require "test_helper"

class StaleDevelopersQueryTest < ActiveSupport::TestCase
  include DevelopersHelper

  test ".stale_and_not_recently_notified returns stale developers with no or older than 30 days notification" do
    travel_to(31.days.ago)
    stale_developer = create_developer
    notified_developer = create_developer(user: users(:developer))
    notified_developer.notify_as_stale
    travel_back

    records = StaleDevelopersQuery.new.stale_and_not_recently_notified
    assert_includes records, stale_developer
    assert_includes records, notified_developer

    stale_developer.notify_as_stale
    refute_includes StaleDevelopersQuery.new.stale_and_not_recently_notified, stale_developer
  end

  test ".stale_and_not_recently_notified returns no developers if previously stale developer updates profile" do
    travel_to(31.days.ago)
    stale_developer = create_developer
    stale_developer.notify_as_stale
    travel_back

    assert_includes StaleDevelopersQuery.new.stale_and_not_recently_notified, stale_developer
    stale_developer.touch
    assert_empty StaleDevelopersQuery.new.stale_and_not_recently_notified
  end

  test ".stale_and_not_recently_notified ignores invisible and developers not looking" do
    travel_to(31.days.ago)
    developer = create_developer(search_status: nil)
    travel_back

    records = StaleDevelopersQuery.new.stale_and_not_recently_notified
    assert_includes records, developer

    developer.search_status = :invisible
    developer.save(touch: false) # Don't update #updated_at.
    refute_includes StaleDevelopersQuery.new.stale_and_not_recently_notified, developer

    developer.search_status = :not_interested
    developer.save(touch: false) # Don't update #updated_at.
    refute_includes StaleDevelopersQuery.new.stale_and_not_recently_notified, developer
  end
end
