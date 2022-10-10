class SubmitButtonComponent < ApplicationComponent
  attr_reader :text, :disable_with, :button_classes

  def initialize(text: nil, disable_with: nil, button_classes: nil)
    @text = text || I18n.t("submit_button_component.save")
    @disable_with = disable_with || I18n.t("submit_button_component.saving")
    @button_classes = button_classes
  end
end
