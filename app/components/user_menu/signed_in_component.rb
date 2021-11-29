class UserMenu::SignedInComponent < ApplicationComponent
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def developer_link?
    (developer? && !business?) | (!developer? && !business?) || (developer? && business?)
  end

  def business_link?
    (business? && !developer?) || (developer? && business?)
  end

  private

  def developer?
    user.developer.present?
  end

  def business?
    user.business.present?
  end
end
