class SortButtonComponent < ApplicationComponent
  attr_reader :title, :name, :value, :form_id

  def initialize(title:, name:, value:, active:, form_id:)
    @title = title
    @name = name
    @value = value
    @active = active
    @form_id = form_id
  end

  def dynamic_classes
    !!@active ? "font-medium text-gray-900" : "text-gray-700"
  end
end
