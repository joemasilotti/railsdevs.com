require 'test_helper'
class InboundEmailJobTest < ActiveJob::TestCase
  include NotificationsHelper

  test "discards job and doesn't retry on Postmark::InactiveRecipientError exception" do
    exception = Postmark::InactiveRecipientError.new('Some error message')
    InboundEmailJob.stubs(:send_email).with('inactive@example.com').raises(exception)

    custom_logger = StringIO.new
    Rails.logger = Logger.new(custom_logger)

    email_payload = {
      'MessageID' => '123',
      'FromFull' => { 'Email' => 'sender@example.com' },
      'MailboxHash' => 'abc',
      'StrippedTextReply' => 'Hello!',
      'Recipient' => 'inactive@example.com'
    }

    assert_no_difference 'InboundEmail.count' do
      assert_raises(Postmark::InactiveRecipientError) do
        InboundEmailJob.perform_now(email_payload)
      end
    end

    logged_message = custom_logger.string
    assert_match(/Inactive recipient error: #{exception.message}/, logged_message)

    assert_difference 'InboundEmail.count', 1 do
      valid_payload = email_payload.merge('Recipient' => 'valid-recipient@example.com')
      InboundEmailJob.perform_now(valid_payload)
    end
  end
end
