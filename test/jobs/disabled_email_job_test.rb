require 'test_helper'

class DisabledEmailJobTest < ActiveJob::TestCase
 include NotificationsHelper
  test "discards job on Postmark::InactiveRecipientError exception" do
  email_payload = payload.merge("Recipient" => "invalid-recipient@example.com")

  custom_logger = StringIO.new
  Rails.logger = Logger.new(custom_logger)

  assert_no_difference "InboundEmail.count" do
    assert_raises(Postmark::InactiveRecipientError) do
      InboundEmailJob.perform_now(email_payload)
    end
  end

  logged_message = custom_logger.string
  assert_match(/Inactive recipient error: /, logged_message)

  assert_difference "InboundEmail.count", 1 do
    InboundEmailJob.perform_now(payload)
  end
end
end
