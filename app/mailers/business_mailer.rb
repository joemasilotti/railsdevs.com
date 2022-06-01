class BusinessMailer < ApplicationMailer
  default from: Rails.configuration.emails.updates_mailbox!
  delegate :pluralize, to: "ActionController::Base.helpers"

  def developer_profiles
    @business = params[:business]
    @developers = params[:developers]
    subject = "#{pluralize(@developers.count, "new developer profile")} added to railsdevs"

    mail(to: @business.user.email, subject:)
  end
end
