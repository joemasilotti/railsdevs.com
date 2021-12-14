class UserMenu::MenuItemComponent < ApplicationComponent
  attr_reader :name, :url, :condition

  def initialize(name, url, condition:)
    @name = name
    @url = url
    @condition = condition
  end

  def render?
    !!condition
  end
end
