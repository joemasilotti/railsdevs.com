require "test_helper"

class ConversationQueryTest < ActiveSupport::TestCase
  include BusinessesHelper
  include DevelopersHelper

  test "all conversations if entity isn't provided" do
    conversation = create_conversation
    query = ConversationQuery.new(nil)
    assert_includes query.records, conversation
  end

  test "conversations involving the entity, if provided" do
    developer = create_developer
    developer_conversation = create_conversation(developer:)
    other_conversation = create_conversation

    query = ConversationQuery.new(developer)

    assert_includes query.records, developer_conversation
    refute_includes query.records, other_conversation
  end

  test "conversations where the developer replied" do
    developer = create_developer
    business = create_business

    replied_to_conversation = create_conversation(developer:)
    replied_to_conversation.messages.create!(sender: developer, body: "Hi, business!")
    left_read_conversation = create_conversation(business:)
    left_read_conversation.messages.create!(sender: business, body: "Hi, developer!")

    query = ConversationQuery.new(nil)

    assert_includes query.replied_to_conversation_ids, replied_to_conversation.id
    refute_includes query.replied_to_conversation_ids, left_read_conversation.id
  end

  test "conversations where a message contains an email address" do
    developer = create_developer

    conversation_with_email = create_conversation(developer:)
    conversation_with_email.messages.create!(sender: developer, body: "me@example.com")
    other_conversation = create_conversation
    other_conversation.messages.create!(sender: developer, body: "Hi!")

    query = ConversationQuery.new(nil)

    assert_includes query.potential_email_conversation_ids, conversation_with_email.id
    refute_includes query.potential_email_conversation_ids, other_conversation.id
  end

  def create_conversation(developer: nil, business: nil)
    developer ||= create_developer
    business ||= create_business
    Conversation.create(developer:, business:)
  end
end
