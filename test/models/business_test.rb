require "test_helper"

class BusinessTest < ActiveSupport::TestCase
  test "successful business creation sends a notification to the admin" do
    user = users(:empty)

    assert_changes "Notification.count", 1 do
      Business.create!(name: "name", company: "company", bio: "bio", user: user)
    end

    assert_equal Notification.last.type, NewBusinessNotification.name
    assert_equal Notification.last.recipient, users(:admin)
  end

  test "conversations relationship doesn't include blocked ones" do
    business = businesses(:with_conversation)

    assert business.conversations.include?(conversations(:one))
    refute business.conversations.include?(conversations(:blocked))
  end
end
