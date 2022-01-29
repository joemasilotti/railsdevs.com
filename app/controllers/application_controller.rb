class ApplicationController < ActionController::Base
  include Pundit
  include StoredLocation

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  around_action :set_locale
  helper_method :resolve_locale

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

  def set_locale(&action)
    locale = if params[:locale].to_s.to_sym.in?(I18n.available_locales)
      params[:locale]
    else
      I18n.default_locale
    end
    I18n.with_locale(locale, &action)
  end

  def default_url_options(options = {})
    options.merge({locale: resolve_locale})
  end

  def resolve_locale(locale = I18n.locale)
    locale == I18n.default_locale ? nil : locale
  end

  def user_not_authorized
    flash[:alert] = I18n.t("pundit.errors.unauthorized")
    redirect_to(request.referrer || root_path)
  end
end
