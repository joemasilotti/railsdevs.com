require "test_helper"

class InboundEmailJobTest < ActiveJob::TestCase
  include NotificationsHelper

  test "always creates an email" do
    assert_changes "InboundEmail.count", 1 do
      InboundEmailJob.perform_now(payload(
        id: "new-message-id",
        from_email: users(:developer).email
      ))
    end

    assert_changes "InboundEmail.count", 1 do
      InboundEmailJob.perform_now(payload)
    end

    email = InboundEmail.last
    assert_equal "7ca91d0d-cf10", email.postmark_message_id
    assert_equal payload, email.payload
  end

  test "creates a message" do
    assert_changes "Message.count", 1 do
      InboundEmailJob.perform_now(payload)
    end

    message = Message.last
    assert_equal conversations(:one), message.conversation
    assert_equal developers(:prospect), message.sender
    assert_equal "A reply via email.", message.body
    assert_equal InboundEmail.last.message, message
  end

  test "sends the message" do
    recipient = users(:subscribed_business)
    assert_sends_notification NewMessageNotification, to: recipient do
      InboundEmailJob.perform_now(payload)
    end
  end

  test "marks notifications as read for the sender" do
    sender_notification = notifications(:message_to_developer)
    recipient_notification = notifications(:message_to_business)

    refute sender_notification.read?
    refute recipient_notification.read?

    InboundEmailJob.perform_now(payload)

    assert sender_notification.reload.read?
    refute recipient_notification.reload.read?
  end

  test "doesn't send a message if not in conversation" do
    assert_no_changes "Message.count" do
      InboundEmailJob.perform_now(payload(from_email: users(:developer).email))
    end
  end

  test "doesn't send a message if already sent (duplicate Postmark email)" do
    assert_changes "Message.count", 1 do
      InboundEmailJob.perform_now(payload)
    end

    assert_no_changes "Message.count" do
      InboundEmailJob.perform_now(payload)
    end
  end

  def payload(id: "7ca91d0d-cf10", from_email: users(:prospect_developer).email)
    {
      "FromFull" => {
        "Email" => from_email
      },
      "MessageID" => id,
      "MailboxHash" => conversations(:one).inbound_email_token,
      "StrippedTextReply" => "A reply via email."
    }
  end
end
