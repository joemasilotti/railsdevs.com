require "test_helper"

class Stats::ConversationTest < ActiveSupport::TestCase
  setup do
    Conversation.create!(developer: developers(:one), business: businesses(:one))
  end

  test "#sent counts all conversations" do
    stats = Stats::Conversation.new(Conversation.all)
    assert_equal 2, stats.sent
  end

  test "#replied counts conversations with a developer response" do
    stats = Stats::Conversation.new(Conversation.all)
    assert_equal 1, stats.replied
  end

  test "#replied_rate calcualtes the percentage of replied conversations" do
    stats = Stats::Conversation.new(Conversation.all)
    assert_equal 0.5, stats.replied_rate
  end

  test "#replied_rate handles no sent messages" do
    stats = Stats::Conversation.new(Conversation.none)
    assert_equal 0, stats.replied_rate
  end
end
