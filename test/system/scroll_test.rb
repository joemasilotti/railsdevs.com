require "application_system_test_case"

class ScrollTest < ApplicationSystemTestCase
  include DevelopersHelper
  include Devise::Test::IntegrationHelpers
  include PagyHelper

  test "scrolling to the message form at the bottom of the conversation page on page load" do
    user = users(:prospect_developer)
    conversation = conversations(:one)

    with_pagy_default_items(5) do
      5.times do
        conversation.messages.create!(sender: user.developer, body: "Message.")
      end

      sign_in(user)

      visit conversation_path(id: conversation.id)

      refute find("#message_body").obscured?
    end
  end

  test "scrolling to bottom of the developers page loads more results for subscribers" do
    with_pagy_default_items(5) do
      5.times { create_developer }

      user = users(:subscribed_business)
      sign_in(user)

      visit developers_path
      refute_text developers(:one).hero

      scroll_to_bottom_of_page
      assert_text developers(:one).hero
    end
  end

  def scroll_to_bottom_of_page
    page.execute_script "window.scrollBy(0,10000)"
  end
end
