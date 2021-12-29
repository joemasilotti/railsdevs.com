class PaywallComponent < ApplicationComponent
  def initialize(user:, paywalled:)
    @user = user
    @paywalled = paywalled
  end

  def paywalled?
    customer? || owner?
  end

  private

  def customer?
    @user.active_business_subscription?
  end

  def owner?
    begin
      @paywalled.user == @user
    rescue
      false
    end
  end
end
