class DeveloperPrimaryActionComponent < ApplicationComponent
  def initialize(user:, developer:)
    @user = user
    @developer = developer
  end

  def owner?
    @user&.developer == @developer
  end
end
