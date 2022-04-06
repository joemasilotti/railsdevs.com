class ApplicationMailer < ActionMailer::Base
  default from: Rails.configuration.support_email
  default message_stream: "outbound"
  layout "mailer"
end
