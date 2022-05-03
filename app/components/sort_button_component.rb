class SortButtonComponent < ApplicationComponent
  attr_reader :title, :name, :value, :form

  def initialize(title:, name: nil, value: nil, enabled: false, form: nil)
    @title = title
    @name = name
    @value = value
    @enabled = enabled
    @form = form
  end

  def dynamic_classes
    !!@enabled ? "font-medium text-gray-900" : "text-gray-700"
  end
end
