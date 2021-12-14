require "test_helper"

class BusinessTest < ActiveSupport::TestCase
  test "successful business creation sends a notification to the admin" do
    user = users(:empty)
    assert_changes "Notification.count", 1 do
      Business.create!(name: "name", company: "company", bio: "bio", user: user)
    end
  end
end
