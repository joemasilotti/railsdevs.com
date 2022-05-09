require "test_helper"

class DeveloperMailerTest < ActionMailer::TestCase
  test "sending the welcome email to a developer" do
    developer = developers(:one)
    email = DeveloperMailer.with(developer:).welcome_email

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal [developer.user.email], email.to
    assert_match(/Thanks for adding your profile!/, email.body.encoded)
  end
end
