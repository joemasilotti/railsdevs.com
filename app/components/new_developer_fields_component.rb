class NewDeveloperFieldsComponent < ApplicationComponent
  include ComponentWithIcon

  attr_reader :account

  def initialize(account, enabled: true)
    @account = account
    @enabled = enabled
  end

  def render?
    enabled? && editing? && missing_fields?
  end

  private

  def enabled?
    !!@enabled
  end

  def editing?
    account&.developer&.persisted?
  end

  def missing_fields?
    account.developer.missing_fields?
  end
end
