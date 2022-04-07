require "application_system_test_case"

class MessageSubmitTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  test "submitting a conversation message using cmd+Enter" do
    user = users(:prospect_developer)
    conversation = conversations(:one)

    sign_in(user)

    visit conversation_path(id: conversation.id)
    fill_in "message_body", with: "This is a cmd+Enter submission"
    find("#message_body").send_keys([:command, :enter])

    assert page.has_selector?("li", text: "This is a cmd+Enter submission")
  end
end
