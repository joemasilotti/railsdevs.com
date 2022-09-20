class SubscriptionCTAComponent < ApplicationComponent
  def initialize(user:, developers_count:)
    @user = user
    @developers_count = developers_count
  end

  def render?
    if @user&.permissions&.active_subscription?
      false
    else
      true
    end
  end

  def title
    t("subscription_cta_component.title")
  end

  def description
    t("subscription_cta_component.description", developers_count: @developers_count)
  end
end
