class NewDeveloperFieldsComponent < ApplicationComponent
  include ComponentWithIcon

  attr_reader :user

  def initialize(user, enabled: true)
    @user = user
    @enabled = enabled
  end

  def render?
    enabled? && user&.developer&.persisted? && user.developer.missing_fields?
  end

  private

  def enabled?
    !!@enabled
  end
end
