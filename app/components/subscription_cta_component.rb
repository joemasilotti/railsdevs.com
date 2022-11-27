class SubscriptionCTAComponent < ApplicationComponent
  private attr_reader :user

  def initialize(user:)
    @user = user
  end

  def developers
    SignificantFigure.new(Developer.visible.count).rounded
  end

  def render?
    Feature.enabled?(:paywalled_search_results) && !customer?
  end

  def customer?
    user&.permissions&.active_subscription?
  end
end
