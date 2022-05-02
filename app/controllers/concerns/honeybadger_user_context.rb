module HoneybadgerUserContext
  extend ActiveSupport::Concern

  included do
    before_action :set_honeybadger_context
  end

  private

  def set_honeybadger_context
    Honeybadger.context(user_id: current_user.id) if signed_in?
  end
end
