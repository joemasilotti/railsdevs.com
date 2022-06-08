class CollapseControlComponent < ApplicationComponent
  attr_reader :title

  def initialize(title, collapsed: false, subcomponent: false)
    @title = title
    @collapsed = collapsed
    @subcomponent = subcomponent
  end

  def title_class
    "font-medium text-gray-900 #{"text-xs" if @subcomponent}"
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
end
