class CollapseControlComponent < ApplicationComponent
  attr_reader :title

  def initialize(title, collapsed: false)
    @title = title
    @collapsed = collapsed
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
