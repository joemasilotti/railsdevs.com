class ApplicationController < ActionController::Base
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = I18n.t("pundit.errors.unauthorized")
    redirect_to(request.referrer || root_path)
  end
end
