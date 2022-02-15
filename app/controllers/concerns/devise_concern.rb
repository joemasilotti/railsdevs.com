module DeviseConcern
  extend ActiveSupport::Concern

  def authenticate_user!
    if user_signed_in?
      super
    else
      redirect_to new_user_session_path, notice: t("sessions.sign_in_hero")
    end
  end
end
