class ApplicationMailer < ActionMailer::Base
  default from: Rails.configuration.support_email
  default host: "hirethepivot.com"
  layout "mailer"
end
