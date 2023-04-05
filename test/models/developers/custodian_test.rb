require "test_helper"

class Developers::CustodianTest < ActiveSupport::TestCase
  include DevelopersHelper
  include NotificationsHelper

  setup do
    travel_to(Developers::Custodian::EARLIEST_TIME)
    @developer = create_developer
    travel_back
  end

  test ".clean_stale_profiles return the number of developers marked stale and notified" do
    assert_equal 1, clean_stale_profiles.length
  end

  test "marks stale and notfy the developers who haven't updated their profile in 3 months" do
    assert_sends_notification Developers::ProfileReminderNotification, to: @developer.user do
      clean_stale_profiles
    end

    assert_equal "not_interested", @developer.reload.search_status
  end

  test "ignore developers who have updated their profile within last 3 months" do
    @developer.touch

    assert_no_changes "@developer.search_status" do
      clean_stale_profiles
    end

    refute_sends_notification Developers::ProfileReminderNotification do
      clean_stale_profiles
    end
  end

  test "ignores not_interested developers" do
    @developer.search_status = :not_interested
    @developer.save(touch: false)

    assert_equal 0, clean_stale_profiles.length
  end

  test "ignores invisible developers" do
    @developer.search_status = :invisible
    @developer.save(touch: false)

    assert_equal 0, clean_stale_profiles.length
  end

  def clean_stale_profiles
    Developers::Custodian.clean_stale_profiles
  end
end
