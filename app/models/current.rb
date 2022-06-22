class Current < ActiveSupport::CurrentAttributes
  attribute :user

  def account
    return nil unless account_id.present?
    @account ||= user&.accounts&.find(account_id)
  end

  private

  def account_id
    session[:account_id] ||= default_account&.id
  end

  def default_account
    user.business || user.developer
  end
end
