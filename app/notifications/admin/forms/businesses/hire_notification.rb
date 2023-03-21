module Admin
  module Forms
    module Businesses
      class HireNotification < ApplicationNotification
        deliver_by :database
        deliver_by :email, mailer: "AdminMailer", method: :forms_businesses_hire

        param :form

        def title
          t("notifications.admin.new_hire_form_notification.title", business: form.business.name)
        end

        def url
          admin_forms_businesses_hire_path(form)
        end

        def form
          params[:form]
        end
      end
    end
  end
end
