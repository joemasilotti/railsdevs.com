class CollapseControlComponent < ApplicationComponent
  renders_one :cta, -> (user:) do
    Users::PaywalledComponent.new(user: user, paywalled: nil, size: :extra_small)
  end

  attr_reader :title

  def initialize(title, collapsed: false, subcomponent: false)
    @title = title
    @collapsed = collapsed
    @subcomponent = subcomponent
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

  def render_content?
    !cta? || cta&.render_content?
  end
end
