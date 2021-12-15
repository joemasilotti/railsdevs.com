require "test_helper"

class MessagingPolicyTest < ActiveSupport::TestCase
  test "businesses can view/create their own conversation" do
    user = users(:with_business)
    developer = developers(:available)
    business = user.business

    conversation = Conversation.create!(developer: developer, business: business)

    assert MessagingPolicy.new(user, conversation).show?
    assert MessagingPolicy.new(user, conversation).create?
  end

  test "businesses cannot view/create another business' conversation" do
    user = users(:with_business)
    developer = developers(:available)
    business = businesses(:two)

    conversation = Conversation.create!(developer: developer, business: business)

    refute MessagingPolicy.new(user, conversation).show?
    refute MessagingPolicy.new(user, conversation).create?
  end

  test "developers can view/create their own conversation" do
    user = users(:with_available_profile)
    developer = user.developer
    business = businesses(:one)

    conversation = Conversation.create!(developer: developer, business: business)

    assert MessagingPolicy.new(user, conversation).show?
    assert MessagingPolicy.new(user, conversation).create?
  end

  test "developers cannot view another developer's conversation" do
    user = users(:with_available_profile)
    developer = developers(:unavailable)
    business = businesses(:one)

    conversation = Conversation.create!(developer: developer, business: business)

    refute MessagingPolicy.new(user, conversation).show?
  end

  test "no one can show or create a blocked conversation" do
    user = users(:with_business)
    developer = developers(:available)
    business = user.business

    conversation = Conversation.create!(developer: developer, business: business, developer_blocked_at: Time.now)

    refute MessagingPolicy.new(user, conversation).show?
    refute MessagingPolicy.new(user, conversation).create?
  end

  test "messages are never blocked" do
    user = users(:with_business_conversation)

    message = Message.create!(conversation: conversations(:one), sender: user.business, body: "Hi!")

    assert MessagingPolicy.new(user, message).show?
    assert MessagingPolicy.new(user, message).create?
  end
end
