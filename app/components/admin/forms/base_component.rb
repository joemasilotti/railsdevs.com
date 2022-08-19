class Admin::Forms::BaseComponent < ApplicationComponent
  attr_reader :form, :field, :classes

  def initialize(form, field, classes:)
    @form = form
    @field = field
    @classes = classes
  end
end
