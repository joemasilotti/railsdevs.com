require "application_system_test_case"

class ScrollTest < ApplicationSystemTestCase
  include DevelopersHelper
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

  test "scrolling to bottom of of the developers page loads more results" do
    # Create more developers to trigger pagination.
    20.times { create_developer }

    visit developers_path
    refute_text "Developer number one"

    scroll_to_bottom_of_page
    assert_text "Developer number one"
  end

  def scroll_to_bottom_of_page
    page.execute_script "window.scrollBy(0,10000)"
  end
end
