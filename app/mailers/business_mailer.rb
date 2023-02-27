class BusinessMailer < ApplicationMailer
  default from: Rails.configuration.emails.updates_mailbox!
  delegate :pluralize, to: "ActionController::Base.helpers"

  def welcome
    notification = params[:record].to_notification
    recipient = params[:recipient]

    @business = notification.business
    subject = notification.title

    mail(
      to: recipient.email,
      from: Rails.configuration.emails.support_mailbox!,
      subject:
    )
  end

  def developer_profiles
    @business = params[:business]
    @developers = params[:developers]
    subject = "#{pluralize(@developers.count, "new developer profile")} added to RailsDevs"

    mail(to: @business.user.email, subject:)
  end

  def new_terms
    @business = params[:business]
    from = Rails.configuration.emails.support_mailbox!
    subject = "Updated RailsDevs terms of use and hiring agreement"
    mail(to: @business.user.email, from:, subject:)
  end
end
