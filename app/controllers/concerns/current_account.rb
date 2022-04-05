module CurrentAccount
  extend ActiveSupport::Concern

  def current_account
    return unless user_signed_in?
    @current_account ||= account_from_session || fallback_account
  end

  private

  def account_from_session
    current_user.accounts.find_by(id: session[:account_id])
  end

  def fallback_account
    current_user.accounts.order(:created_at).first
  end
end
