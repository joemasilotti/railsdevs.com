class DeveloperProfileActionComponent < ApplicationComponent
  attr_reader :account

  def initialize(account)
    @account = account
  end

  def update_profile?
    account&.developer
  end
end
