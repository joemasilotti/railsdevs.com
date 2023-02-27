require "test_helper"

class BusinessMailerTest < ActionMailer::TestCase
  test "calling welcome enqueues the mailer" do
    assert_emails 1 do
      Businesses::NewBusinessNotification.with(business:).deliver(recipient)
    end
  end

  end

  def business
    businesses(:one)
  end

  def recipient
    business.user
  end
end
