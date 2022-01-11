class SubmitButtonComponent < ApplicationComponent
  attr_reader :text, :disable_with, :button_classes

  def initialize(text:, disable_with: nil, button_classes: nil)
    @text = text
    @disable_with = disable_with
    @button_classes = button_classes
  end
end
