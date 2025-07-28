class SafeMailerJob < ActionMailer::MailDeliveryJob
  rescue_from Postmark::InactiveRecipientError do |error|
    Rails.logger.warn("Postmark inactive recipient: #{error.message}")
  end
end
