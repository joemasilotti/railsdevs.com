require "test_helper"

class DeveloperRegistrationTest < ActiveSupport::TestCase
  include DevelopersHelper
  include ActionMailer::TestHelper

  setup do
    @user = users(:empty)
  end

  test "creating a developer is succesful" do
    assert_difference "Developer.count", 1 do
      result = DeveloperRegistration.new(developer_attributes, user: @user).create
      assert result.success?
      assert_equal Developer.last, result.developer
    end
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

  test "invalid developers don't send notifications nor welcome emails" do
    assert_no_difference "Notification.count" do
      result = DeveloperRegistration.new({name: "Name"}, user: @user).create
      assert_no_enqueued_emails
      refute result.success?
      assert result.developer.invalid?
    end
  end
end
