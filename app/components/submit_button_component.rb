class SubmitButtonComponent < ApplicationComponent
  attr_reader :text, :disable_with, :button_classes, :data

  def initialize(text: nil, disable_with: nil, button_classes: nil, data: {})
    @text = text || I18n.t("submit_button_component.save")
    @disable_with = disable_with || I18n.t("submit_button_component.saving")
    @button_classes = button_classes
    @data = data
  end
end
