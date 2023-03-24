module Developers
  class CelebrationPackageRequestsController < ApplicationController
    before_action :test
    before_action :authenticate_user!
    before_action :require_developer!

    def new
      @form = Developers::CelebrationPackageRequest.new(developer: current_user.developer)
    end

    def create
      @form = Developers::CelebrationPackageRequest.new(form_params)
      if @form.save_and_notify
        redirect_to root_path, notice: t(".success")
      else
        render :new, status: :unprocessable_entity
      end
    end

    private

    def test
    end

    def require_developer!
      if current_user.developer.blank?
        redirect_to new_developer_path, notice: I18n.t("errors.developer_blank")
      end
    end

    def form_params
      params.require(:developers_celebration_package_request).permit(
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
