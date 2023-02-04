require "test_helper"

class BusinessMailerTest < ActionMailer::TestCase
  test "subscribed" do
    business = businesses(:subscriber)
    BusinessMailer.with(business:).subscribed.deliver
  end
end
