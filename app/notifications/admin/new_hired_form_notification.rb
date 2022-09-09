module Admin
  class NewHiredFormNotification < ApplicationNotification
    deliver_by :database
    deliver_by :email, mailer: "AdminMailer", method: :new_hired_form

    param :developer, :form

    def title
      t("notifications.admin.new_hired_form_notification.title", developer: developer.name)
    end

    def url
      admin_hired_form_path(form)
    end

    def developer
      params[:developer]
    end

    def form
      params[:form]
    end
  end
end
