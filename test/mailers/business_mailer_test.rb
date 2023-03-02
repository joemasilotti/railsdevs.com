require "test_helper"

class BusinessMailerTest < ActionMailer::TestCase
  test "subscribed" do
    BusinessMailer.with(business:).subscribed.deliver_later
    assert_enqueued_emails 1
  end

  def business
    businesses(:subscriber)
  end
end
