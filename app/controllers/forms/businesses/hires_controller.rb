module Forms
  module Businesses
    class HiresController < ApplicationController
      before_action :authenticate_user!
      before_action :require_business!

      def new
        @form = Forms::Businesses::Hire.new(business: current_user.business)
      end

      def create
        @form = Forms::Businesses::Hire.new(form_params)
        if @form.save_and_notify
          redirect_to root_path, notice: t(".success")
        else
          render :new, status: :unprocessable_entity
        end
      end

      private

      def business
        @business = current_user.business
      end

      def require_business!
        unless business.present?
          store_location!
          redirect_to new_business_path, notice: I18n.t("errors.business_blank")
        end
      end

      def form_params
        params.require(:forms_businesses_hire).permit(
          :billing_address,
          :developer_name,
          :annual_salary,
          :position,
          :start_date,
          :employment_type,
          :feedback
        ).merge(business: business)
      end
    end
  end
end
