require "test_helper"

class WelcomeMailerTest < ActionMailer::TestCase
  test "welcome developer email test" do
    @developer = Developer.first
    # Create the email and store it for further assertions
    email = WelcomeMailer.with(developer: @developer).developer_welcome_email

    # Send the email, then test that it got queued
    assert_emails 1 do
      email.deliver_now
    end

    # Test the body of the sent email contains what we expect it to
    assert_equal ["joe@masilotti.com"], email.from
    assert_equal [@developer.user.email], email.to
    assert_equal "Welcome to railsdevs!", email.subject
    assert_equal read_fixture("welcome_developer_text").join, email.text_part.body.to_s.strip
  end

  test "welcome buisness email test" do
    @business = Business.first
    # Create the email and store it for further assertions
    email = WelcomeMailer.with(business: @business).business_welcome_email

    # Send the email, then test that it got queued
    assert_emails 1 do
      email.deliver_now
    end

    # Test the body of the sent email contains what we expect it to
    assert_equal ["joe@masilotti.com"], email.from
    assert_equal [@business.user.email], email.to
    assert_equal "Welcome to railsdevs!", email.subject
    assert_equal read_fixture("welcome_business_text").join, email.text_part.body.to_s.strip
  end
end
