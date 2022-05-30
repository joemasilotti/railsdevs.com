class DeveloperPrimaryActionComponent < ApplicationComponent
  attr_reader :user, :developer, :business

  def initialize(user:, developer:, business:)
    @user = user
    @developer = developer
    @business = business
  end

  def owner?
    user&.developer == developer
  end

  def conversation
    return nil
    Conversation.find_by(developer:, business:)
  end
end
