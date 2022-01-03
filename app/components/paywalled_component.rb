class PaywalledComponent < ApplicationComponent
  def initialize(user:, paywalled:)
    @user = user
    @paywalled = paywalled
  end

  def render?
    customer? || owner?
  end

  private

  def customer?
    @user&.active_business_subscription?
  end

  def owner?
    @paywalled&.user == @user && @user.present?
  end
end
