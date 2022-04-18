require "test_helper"

class DeveloperMailerTest < ActionMailer::TestCase
  test "welcome developer email test" do
    @developer = Developer.first
    email = DeveloperMailer.with(developer: @developer).welcome_email

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal [@developer.user.email], email.to
    assert_match /added your developer profile/, email.body.encoded
  end
end
