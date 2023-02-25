class BusinessMailer < ApplicationMailer
  default from: Rails.configuration.emails.updates_mailbox!
  delegate :pluralize, to: "ActionController::Base.helpers"

  def developer_profiles
    @business = params[:business]
    @developers = params[:developers]
    subject = "#{pluralize(@developers.count, "new developer profile")} added to #{Rails.configuration.strings.project_name}"

    mail(to: @business.user.email, subject:)
  end

  def new_terms
    @business = params[:business]
    from = Rails.configuration.emails.support_mailbox!
    subject = "Updated #{Rails.configuration.strings.project_name} terms of use and hiring agreement"
    mail(to: @business.user.email, from:, subject:)
  end
end
