require "test_helper"

class MessagesMailboxTest < ActionMailbox::TestCase
  test "a recipient can continue the conversation" do
    conversation = conversations(:one)
    signed_conversation_id = conversation.signed_id(purpose: :message)

    assert_changes "Message.count", 1 do
      receive_inbound_email_from_mail \
        to: "message-#{signed_conversation_id}@example.com",
        from: conversation.developer.user.email,
        body: "Email body."
    end

    message = Message.last
    assert_equal conversation, message.conversation
    assert_equal conversation.developer, message.sender
    assert_equal "Email body.", message.body
  end

  test "invalid conversation signatures bounce" do
    conversation = conversations(:one)

    email = receive_inbound_email_from_mail \
      to: "message-invalid-signature@example.com",
      from: conversation.developer.user.email,
      body: "Email body."

    assert email.bounced?
  end

  test "invalid users bounce" do
    conversation = conversations(:one)
    signed_conversation_id = conversation.signed_id(purpose: :message)

    email = receive_inbound_email_from_mail \
      to: "message-#{signed_conversation_id}@example.com",
      from: "invalid@example.com",
      body: "Email body."

    assert email.bounced?
  end
end
