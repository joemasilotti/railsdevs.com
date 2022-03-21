require "application_system_test_case"

class ScrollTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:with_developer_conversation)
    @conversation = @user.conversations.first

    (1..20).each do |n|
      @message = @conversation.messages.create!(id: @conversation, sender: @user.developer, body: "This is test message ##{n}.")
    end
  end

  test "scrolling to the message form at the bottom of the conversation page on page load" do
    sign_in(@user)

    visit conversation_path(id: @conversation.id)

    refute find("#message_body").obscured?
  end
end
