class SubmitButtonComponent < ApplicationComponent
  attr_reader :text, :disable_with

  def initialize(text:, disable_with: nil)
    @text = text
    @disable_with = disable_with
  end
end
