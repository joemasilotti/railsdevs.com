class CollapseControlComponent < ApplicationComponent
  attr_reader :title
  private attr_reader :user

  def initialize(title, collapsed: false, subcomponent: false, paywalled: false, user: nil)
    @title = title
    @collapsed = collapsed
    @subcomponent = subcomponent
    @paywalled = paywalled
    @user = user
  end

  def minus_icon_class
    "hidden" if collapsed?
  end

  def plus_icon_class
    "hidden" unless collapsed?
  end

  private

  def collapsed?
    !!@collapsed
  end

  def subcomponent?
    !!@subcomponent
  end

  def paywalled?
    @paywalled
  end

  def customer?
    user&.permissions&.active_subscription?
  end
end
