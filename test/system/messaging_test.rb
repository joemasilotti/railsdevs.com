require "application_system_test_case"

class MessagingTest < ApplicationSystemTestCase
  test "sending a message via a Turbo Stream" do
    sign_in businesses(:with_conversation).user
    visit conversation_path(conversations(:one), locale: :en)

    fill_in "Add your message", with: "Hello!"
    click_button "Send"

    assert_text "Hello!"
  end
end
