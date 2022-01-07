class SubmitButtonComponent < ApplicationComponent
  attr_reader :text, :disable_with, :button_clasess

  def initialize(text:, disable_with: nil, button_classes: nil)
    @text = text
    @disable_with = disable_with
    @button_clasess = button_clasess || default_button_clasess
  end

  def default_button_clasess
    "ml-3 inline-flex justify-center align-center py-2 px-4 border border-transparent"\
    "shadow-sm text-sm font-medium rounded-md text-white bg-gray-600 cursor-pointer"\
    "hover:bg-gray-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-gray-500"
  end
end
