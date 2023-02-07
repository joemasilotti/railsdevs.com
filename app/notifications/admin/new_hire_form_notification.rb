module Admin
  class NewHireFormNotification < ApplicationNotification
    deliver_by :database
    deliver_by :email, mailer: "AdminMailer", method: :new_hire_form

    param :form

    def title
      t("notifications.admin.new_hire_form_notification.title", business: form.business.name)
    end

    def url
      admin_hire_form_path(form)
    end

    def form
      params[:form]
    end
  end
end
