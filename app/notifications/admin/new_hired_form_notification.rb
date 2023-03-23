module Admin
  class NewHiredFormNotification < ApplicationNotification
    deliver_by :database
    deliver_by :email, mailer: "AdminMailer", method: :new_hired_form

    param :form

    def title
      t("notifications.admin.new_hired_form_notification.title", developer: form.developer.name)
    end

    def url
      admin_developers_form_path(form)
    end

    def form
      params[:form]
    end
  end
end
