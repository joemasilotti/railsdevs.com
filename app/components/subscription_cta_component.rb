class SubscriptionCTAComponent < ApplicationComponent
  private attr_reader :user

  def initialize(user:)
    @user = user
  end

  def developers
    SignificantFigure.new(Developer.visible.count).rounded
  end
end
