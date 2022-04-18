require "test_helper"

class BusinessMailerTest < ActionMailer::TestCase
  test "sending the welcome email to a business" do
    business = businesses(:one)
    email = BusinessMailer.with(business:).welcome_email

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal [business.user.email], email.to
    assert_match(/added your business/, email.body.encoded)
  end
end
