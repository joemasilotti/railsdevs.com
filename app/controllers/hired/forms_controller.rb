module Hired
  class FormsController < ApplicationController
    before_action :authenticate_user!
    before_action :require_developer!

    def new
      @form = Hired::Form.new(developer: current_user.developer)
    end

    def create
      @form = Hired::Form.new(form_params)
      if @form.save
        redirect_to root_path, notice: t(".success")
      else
        render :new, status: :unprocessable_entity
      end
    end

    private

    def require_developer!
      if current_user.developer.blank?
        redirect_to new_developer_path, notice: I18n.t("errors.developer_blank")
      end
    end

    def form_params
      params.require(:hired_form).permit(
        :address,
        :company,
        :position,
        :start_date,
        :employment_type,
        :feedback
      ).merge(developer: current_user.developer)
    end
  end
end
