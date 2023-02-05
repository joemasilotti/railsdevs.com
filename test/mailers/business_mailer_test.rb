require "test_helper"

class BusinessMailerTest < ActionMailer::TestCase
  test "calling welcome enqueues the mailer" do
    BusinessMailer.with(business:).welcome.deliver_later
    assert_enqueued_emails 1
  end

  def business
    businesses(:one)
  end

  def recipient
    business.user
  end
end
