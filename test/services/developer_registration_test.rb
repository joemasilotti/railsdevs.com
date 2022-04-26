require "test_helper"

class DeveloperRegistrationTest < ActiveSupport::TestCase
  include DevelopersHelper
  include ActionMailer::TestHelper

  setup do
    @user = users(:empty)
  end

  test "creating a developer sends the welcome email" do
    result = DeveloperRegistration.new(developer_attributes, user: @user).create
    assert_enqueued_email_with DeveloperMailer, :welcome_email, args: {developer: result.developer}
  end

  test "successful profile creation sends a notification to the admins" do
    assert_difference "Notification.count", 1 do
      DeveloperRegistration.new(developer_attributes, user: @user).create
    end

    assert_equal Notification.last.type, NewDeveloperProfileNotification.name
    assert_equal Notification.last.recipient, users(:admin)
  end
end
