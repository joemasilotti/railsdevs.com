class SubscriptionCTAComponent < ApplicationComponent
  private attr_reader :user

  def initialize(user:, developers:)
    @user = user
    @developers = developers
  end

  def developers
    SignificantFigure.new(@developers).rounded
  end

  def render?
    !user&.permissions&.active_subscription?
  end
end
