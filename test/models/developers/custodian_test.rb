require "test_helper"

class Developers::CustodianTest < ActiveSupport::TestCase
  include DevelopersHelper
  include NotificationsHelper

  setup do
    @developer = create_developer
    @developer.update!(updated_at: 31.days.ago)
  end

  test "marks stale developers as not interested" do
    clean_stale_profiles
    assert_equal @developer.reload.search_status, "not_interested"
  end

  test "sends stale developer notification" do
    assert_sends_notification Developers::ProfileReminderNotification, to: @developer.user do
      clean_stale_profiles
    end
  end

  def clean_stale_profiles
    Developers::Custodian.clean_stale_profiles
  end
end
