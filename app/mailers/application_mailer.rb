class ApplicationMailer < ActionMailer::Base
  default from: Rails.configuration.emails.support_mailbox!
  default reply_to: Rails.configuration.emails.support!
  default message_stream: "outbound"
  layout "mailer"
end
