require "test_helper"

class BusinessRegistrationTest < ActiveSupport::TestCase
  include ActionMailer::TestHelper

  setup do
    @user = users(:empty)
  end

  test "creating a business sends a notification to the admin" do
    assert_difference "Notification.count", 1 do
      BusinessRegistration.new(business_attributes, user: @user).create
    end

    assert_equal Notification.last.type, NewBusinessNotification.name
    assert_equal Notification.last.recipient, users(:admin)
  end

  test "creating a business sends the welcome email" do
    result = BusinessRegistration.new(business_attributes, user: @user).create
    assert_enqueued_email_with BusinessMailer, :welcome_email, args: {business: result.business}
  end

  def business_attributes
    {
      user: @user,
      name: "Name",
      company: "Company",
      bio: "Bio",
      avatar: active_storage_blobs(:basecamp)
    }
  end
end
