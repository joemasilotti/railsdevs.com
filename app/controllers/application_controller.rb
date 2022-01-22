class ApplicationController < ActionController::Base
  include Pundit
  include StoredLocation

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  before_action :set_locale

  def after_sign_in_path_for(user)
    if (stored_location = stored_location_for(:user)).present?
      stored_location
    elsif user.developer.present? || user.business.present?
      super
    else
      new_role_path
    end
  end

  private

  def set_locale
    I18n.locale = if params[:locale].to_s.to_sym.in?(I18n.available_locales)
      params[:locale]
    else
      I18n.default_locale
    end
  end

  def default_url_options(options = {})
    options.merge({locale: I18n.locale})
  end

  def user_not_authorized
    flash[:alert] = I18n.t("pundit.errors.unauthorized")
    redirect_to(request.referrer || root_path)
  end
end
