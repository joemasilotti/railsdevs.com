require "test_helper"

class BusinessMailerTest < ActionMailer::TestCase
  test "welcome business email test" do
    @business = Business.first
    email = BusinessMailer.with(business: @business).welcome_email

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal [@business.user.email], email.to
    assert_match /added your business profile/, email.body.encoded
  end
end
