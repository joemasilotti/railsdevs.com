class ApplicationController < ActionController::Base
  include Pundit
  include StoredLocation

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  around_action :switch_locale

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

  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  def default_url_options(options = {})
    options.merge({locale: I18n.locale})
  end

  def user_not_authorized
    flash[:alert] = I18n.t("pundit.errors.unauthorized")
    redirect_to(request.referrer || root_path)
  end
end
