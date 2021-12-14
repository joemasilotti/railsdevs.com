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
end
