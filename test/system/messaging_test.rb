require "application_system_test_case"

class MessagingTest < ApplicationSystemTestCase
  test "sending a message via a Turbo Stream" do
    sign_in businesses(:subscriber).user
    visit conversation_path(conversations(:one), locale: :en)

    fill_in "Add your message", with: "Hello!"
    click_button "Send"

    within "#messages" do
      assert_text "Hello!"
    end
  end
end
