require "test_helper"

class Developers::NotificationsTest < ActiveSupport::TestCase
  include ActionMailer::TestHelper
  include DevelopersHelper
  include NotificationsHelper

  test "sends a notification to the admins" do
    developer = Developer.new(developer_attributes)
    assert_sends_notification Admin::NewDeveloperNotification, to: users(:admin) do
      assert developer.save_and_notify
    end
  end

  test "sends a welcome email" do
    developer = Developer.new(developer_attributes)
    assert_enqueued_email_with DeveloperMailer, :welcome, args: {developer:} do
      assert developer.save_and_notify
    end
  end

  test "invalid records don't send notifications or emails" do
    developer = Developer.new
    refute_sends_notifications do
      assert_enqueued_emails 0 do
        refute developer.save_and_notify
      end
    end
  end

  test "changing search status from looking to not alerts admins" do
    developer = developers(:one)

    assert_no_difference "Notification.count" do
      assert developer.update_and_notify(search_status: :open)
    end

    assert_sends_notification Admin::PotentialHireNotification, to: users(:admin) do
      assert developer.update_and_notify(search_status: :not_interested)
    end

    refute_sends_notifications do
      assert developer.update_and_notify(search_status: :invisible)
    end
  end

  test "admins do not get alerted to new accounts changing search status" do
    developer = Developer.create!(developer_attributes.merge(search_status: :actively_looking))
    assert_no_difference "Notification.count" do
      developer.update_and_notify(search_status: :open)
    end
  end

  test "invalid updates don't notify admins" do
    developer = developers(:one)

    assert_no_difference "Notification.count" do
      refute developer.update_and_notify(search_status: :not_interested, name: nil)
    end
  end

  test "notifies the developer when they are invisibilized" do
    assert_sends_notification Developers::InvisiblizeNotification, to: users(:developer) do
      developers(:one).invisiblize_and_notify!
    end
  end

  test "sends a stale notification email" do
    developer = create_developer
    assert_sends_notification Developers::ProfileReminderNotification, to: developer.user do
      developer.notify_as_stale
    end
  end

  test "does not send a stale notification email if developer opts out" do
    developer = create_developer(profile_reminder_notifications: false)
    refute_sends_notification Developers::ProfileReminderNotification do
      developer.notify_as_stale
    end
  end

  test "sends a feature update notification email" do
    developer = create_developer
    assert_sends_notification Developers::ProductAnnouncementNotification, to: developer.user do
      developer.send_product_announcement
    end
  end

  test "does not send a feature update notification email if developer opts out" do
    developer = create_developer(product_announcement_notifications: false)
    refute_sends_notification Developers::ProductAnnouncementNotification do
      developer.send_product_announcement
    end
  end

  test "does not send a feature update notification email if developer is invisible" do
    developer = Developer.create!(developer_attributes.merge(search_status: :invisible))
    refute_sends_notification Developers::ProductAnnouncementNotification do
      developer.send_product_announcement
    end
  end

  test "does not send a feature update notification email if developer is not currently interested" do
    developer = Developer.create!(developer_attributes.merge(search_status: :not_interested))
    refute_sends_notification Developers::ProductAnnouncementNotification do
      developer.send_product_announcement
    end
  end
end
