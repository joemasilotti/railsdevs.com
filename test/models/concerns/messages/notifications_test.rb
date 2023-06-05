require "test_helper"

class Messages::NotificationsTest < ActiveSupport::TestCase
  include ActiveJob::TestHelper
  include NotificationsHelper

  test "sends a notification to the recipient" do
    developer = developers(:one)
    business = businesses(:one)

    message = Message.new(developer:, business:, sender: business, body: "Hello!")
    assert_sends_notification NewMessageNotification do
      assert message.save_and_notify
    end
  end

  test "sends a notifciation to admins if this started a new conversation" do
    developer = developers(:one)
    business = businesses(:one)

    message = Message.new(developer:, business:, sender: business, body: "Hello!")

    assert_sends_notification Admin::NewConversationNotification do
      assert message.save_and_notify(cold_message: true)
    end
    assert_equal message.conversation, Notification.last.to_notification.conversation

    refute_sends_notification Admin::NewConversationNotification do
      assert message.save_and_notify(cold_message: false)
    end
  end

  test "queues a job to update the developer's response rate if this started a new conversation" do
    developer = developers(:one)
    business = businesses(:one)

    message = Message.new(developer:, business:, sender: business, body: "Hello!")

    assert_enqueued_with(job: UpdateDeveloperResponseRateJob, args: [developer.id]) do
      assert message.save_and_notify(cold_message: true)
    end
  end

  test "doesn't queue a job to update the developer's response rate if this didn't start a new conversation" do
    developer = developers(:one)
    business = businesses(:one)

    message = Message.new(developer:, business:, sender: business, body: "Hello!")

    assert_no_enqueued_jobs only: UpdateDeveloperResponseRateJob do
      assert message.save_and_notify(cold_message: false)
    end
  end

  test "invalid records don't send notifications" do
    message = Message.new
    refute_sends_notifications do
      refute message.save_and_notify
    end
  end
end
