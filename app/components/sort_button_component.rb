class SortButtonComponent < ApplicationComponent
  attr_reader :title, :name, :value

  def initialize(title:, name: nil, value: nil, enabled: false)
    @title = title
    @name = name
    @value = value
    @enabled = enabled
  end

  def dynamic_classes
    !!@enabled ? "font-medium text-gray-900" : "text-gray-700"
  end
end
