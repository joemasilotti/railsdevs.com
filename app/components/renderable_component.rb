class RenderableComponent < ApplicationComponent
  attr_reader :classes

  def initialize(classes = nil)
    @classes = classes
  end

  def render?
    content.present?
  end
end
