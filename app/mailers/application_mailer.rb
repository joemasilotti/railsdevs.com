class ApplicationMailer < ActionMailer::Base
  default from: Rails.configuration.support_email
  layout "mailer"
end
