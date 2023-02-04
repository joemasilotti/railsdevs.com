require "test_helper"

class BusinessMailerTest < ActionMailer::TestCase
  test "subscribed" do
    BusinessMailer.with(business:).subscribed.deliver
  end

  def business
    businesses(:subscriber)
  end
end
