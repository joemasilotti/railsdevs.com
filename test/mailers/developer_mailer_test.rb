require "test_helper"

class DeveloperMailerTest < ActionMailer::TestCase
  test "welcome developer email test" do
    @developer = Developer.first
    email = DeveloperMailer.with(developer: @developer).developer_welcome_email

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal [@developer.user.email], email.to
    assert_not_nil email.body.to_s
  end
end
