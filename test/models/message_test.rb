require "test_helper"

class MessageTest < ActiveSupport::TestCase
  test "user is sender if they are the associated developer" do
    user = users(:prospect_developer)
    assert messages(:from_developer).sender?(user)
    refute messages(:from_business).sender?(user)
  end

  test "user is sender if they are the associated business" do
    user = users(:subscribed_business)
    assert messages(:from_business).sender?(user)
    refute messages(:from_developer).sender?(user)
  end

  test "user is not the sender if they are neither the associated developer nor business" do
    user = users(:empty)
    refute messages(:from_developer).sender?(user)
  end

  test "last_message_in_conversation?" do
    first_message = messages(:from_developer)
    conversation = first_message.conversation
    sender = users(:empty)
    last_message = conversation.messages.create!(body: "Foo", sender:)

    assert_not first_message.last_message_in_conversation?
    assert last_message.last_message_in_conversation?
  end

  test "read_at returns nil if no notification" do
    message = messages(:from_business)

    assert_nil message.read_at
  end

  test "read_at returns nil if notification is not read" do
    message = messages(:from_developer)

    assert_nil message.read_at
  end

  test "read_at returns timestamp from notification" do
    message = messages(:from_developer)
    message.notifications_as_message.last.mark_as_read!

    assert_not_nil message.read_at
  end

  test "body_html is filled with rendered html version of body" do
    message = Message.new(body: "Check out https://railsdevs.com/!")

    assert_equal '<p>Check out <a href="https://railsdevs.com/" target="_blank">https://railsdevs.com/</a>!</p>', message.body_html
  end

  test "user (developer) has their first message" do
    developer = users(:developer).developer
    business = users(:subscribed_business).business
    conversation = Conversation.find_or_initialize_by(business:, developer:)
    Message.create(body: "Hello", sender: business, conversation:)

    assert Message.first_message?(developer)
  end

  test "user (developer) doesn't have any message" do
    user = users(:developer)
    refute Message.first_message?(user.developer)
  end

  test "user (developer) has many messages" do
    user = users(:prospect_developer)
    refute Message.first_message?(user.developer)
  end
end
