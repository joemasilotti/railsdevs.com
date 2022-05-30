class ApplicationMailer < ActionMailer::Base
  default from: Rails.configuration.emails.support_mailbox!
  default message_stream: "outbound"
  layout "mailer"
end
