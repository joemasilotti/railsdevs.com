require "application_system_test_case"

class ScrollTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  test "scrolling to the message form at the bottom of the conversation page on page load" do
    user = users(:prospect_developer)
    conversation = conversations(:one)

    (1..20).each do |n|
      conversation.messages.create!(id: conversation, sender: user.developer, body: "This is test message ##{n}.")
    end

    sign_in(user)

    visit conversation_path(id: conversation.id)

    refute find("#message_body").obscured?
  end
end
