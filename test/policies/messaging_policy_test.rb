require "test_helper"

class MessagingPolicyTest < ActiveSupport::TestCase
  test "businesses can view/create their own conversation" do
    user = users(:business)
    developer = developers(:one)
    business = user.business

    conversation = Conversation.create!(developer:, business:)

    assert MessagingPolicy.new(user, conversation).show?
    assert MessagingPolicy.new(user, conversation).create?
  end

  test "businesses cannot view/create another business' conversation" do
    user = users(:business)
    developer = developers(:one)
    business = businesses(:subscriber)

    conversation = Conversation.create!(developer:, business:)

    refute MessagingPolicy.new(user, conversation).show?
    refute MessagingPolicy.new(user, conversation).create?
  end

  test "developers can view/create their own conversation" do
    user = users(:developer)
    developer = user.developer
    business = businesses(:one)

    conversation = Conversation.create!(developer:, business:)

    assert MessagingPolicy.new(user, conversation).show?
    assert MessagingPolicy.new(user, conversation).create?
  end

  test "developers cannot view another developer's conversation" do
    user = users(:developer)
    developer = developers(:prospect)
    business = businesses(:one)

    conversation = Conversation.create!(developer:, business:)

    refute MessagingPolicy.new(user, conversation).show?
  end

  test "no one can show or create a blocked conversation" do
    user = users(:business)
    developer = developers(:one)
    business = user.business

    conversation = Conversation.create!(developer:, business:, developer_blocked_at: Time.now)

    refute MessagingPolicy.new(user, conversation).show?
    refute MessagingPolicy.new(user, conversation).create?
  end

  test "messages are never blocked" do
    user = users(:subscribed_business)

    message = Message.create!(conversation: conversations(:one), sender: user.business, body: "Hi!")

    assert MessagingPolicy.new(user, message).show?
    assert MessagingPolicy.new(user, message).create?
  end

  test "admins can view any conversation" do
    conversation = conversations(:one)

    user = users(:admin)
    assert MessagingPolicy.new(user, conversation).show?

    conversation.touch(:developer_blocked_at)
    assert MessagingPolicy.new(user, conversation).show?
  end
end
