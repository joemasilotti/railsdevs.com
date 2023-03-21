module Developers
  class ProductAnnouncementNotification < ApplicationNotification
    deliver_by :database, if: :deliver_notification?
    deliver_by :email, mailer: "DeveloperMailer", method: :product_announcement, if: :deliver_notification?

    param :developer

    def developer
      params[:developer]
    end

    def title
      t("notifications.developers.product_announcement_notification.title")
    end

    def email_subject
      t("notifications.developers.product_announcement_notification.email_subject")
    end

    def url
      edit_developer_url(developer, anchor: "specialties")
    end

    def deliver_notification?
      developer.product_announcement_notifications? && developer.visible? && !developer.not_interested?
    end
  end
end
