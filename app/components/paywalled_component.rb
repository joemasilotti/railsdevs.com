class PaywalledComponent < ApplicationComponent
  def initialize(user:, paywalled:, size: nil)
    @user = user
    @paywalled = paywalled
    @size = size
  end

  def render_content?
    customer? || owner?
  end

  def small?
    @size == :small
  end

  def large?
    @size == :large
  end

  private

  def customer?
    @user&.active_business_subscription?
  end

  def owner?
    @paywalled&.user == @user && @user.present?
  end
end
