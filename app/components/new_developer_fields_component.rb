class NewDeveloperFieldsComponent < ApplicationComponent
  include ComponentWithIcon

  attr_reader :user

  def initialize(user)
    @user = user
  end

  def render?
    user&.developer&.persisted? && user.developer.missing_fields?
  end
end
