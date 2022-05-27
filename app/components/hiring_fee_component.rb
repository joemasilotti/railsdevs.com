class HiringFeeComponent < ApplicationComponent
  private attr_reader :user, :conversation

  def initialize(user, conversation)
    @user = user
    @conversation = conversation
  end

  def render?
    Businesses::Permission.new(user.subscriptions).pays_hiring_fee? &&
      conversation.hiring_fee_eligible?
  end

  def developer
    conversation.developer.name
  end

  def recipient
    Rails.configuration.support_email
  end

  def subject
    "I hired a developer via railsdevs"
  end

  def body
    "Hi Joe, I hired #{developer} via railsdevs and would like to coordinate paying the fee. Their starting salary is: "
  end
end
