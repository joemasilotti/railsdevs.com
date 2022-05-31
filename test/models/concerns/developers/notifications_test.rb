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

  test "invalid records don't send notifications" do
    developer = Developer.new
    refute_sends_notifications do
      refute developer.save_and_notify
    end
  end

  test "sends a welcome notification" do
    developer = Developer.new(developer_attributes)
    assert_sends_notification Developers::WelcomeNotification, to: developer.user do
      assert developer.save_and_notify
    end
  end

  test "invalid records don't send welcome notifications" do
    developer = Developer.new
    refute_sends_notifications do
      refute developer.save_and_notify
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
end
