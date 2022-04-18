require "test_helper"

class BusinessMailerTest < ActionMailer::TestCase
  test "welcome business email test" do
    @business = Business.first
    email = BusinessMailer.with(business: @business).business_welcome_email

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal [@business.user.email], email.to
    assert_not_nil email.body.to_s
  end
end
