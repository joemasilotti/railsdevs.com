require "test_helper"

class MessagesMailboxTest < ActionMailbox::TestCase
  setup do
    @conversation = conversations(:one)
  end

  test "a recipient can continue the conversation" do
    assert_changes "Message.count", 1 do
      receive_inbound_email(from: @conversation.business)
    end
    message = Message.last
    assert_equal @conversation, message.conversation
    assert_equal @conversation.business, message.sender
    assert_equal "Email body.", message.body

    assert_changes "Message.count", 1 do
      receive_inbound_email(from: @conversation.developer)
    end
    assert_equal @conversation.developer, Message.last.sender
  end

  test "invalid conversation signatures bounce" do
    email = receive_inbound_email(
      from: @conversation.developer,
      valid_signed_id: false
    )

    assert email.bounced?
  end

  test "invalid users bounce" do
    email = receive_inbound_email(
      from: developers(:one),
      valid_signed_id: false
    )

    assert email.bounced?
  end

  test "businesses without an active subscription can't send messages" do
    pay_subscriptions(:full_time).delete

    assert_no_changes "Message.count" do
      email = receive_inbound_email(from: @conversation.business)
      assert email.bounced?
    end
  end

  def receive_inbound_email(from:, body: "Email body.", valid_signed_id: true)
    id = valid_signed_id ? conversation_signed_id : "invalid-id"

    receive_inbound_email_from_mail \
      to: "message-#{id}@example.com",
      from: from.user.email,
      body:
  end

  def conversation_signed_id
    @conversation.signed_id(purpose: :message)
  end
end
