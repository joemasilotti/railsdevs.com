class SortButtonComponent < ApplicationComponent
  attr_reader :title, :value, :form_id

  def initialize(title:, name:, value:, active:, form_id:, scope: nil)
    @title = title
    @name = name
    @value = value
    @active = active
    @form_id = form_id
    @scope = scope
  end

  def name
    if @scope.present?
      "#{@scope}[#{@name}]"
    else
      @name
    end
  end

  def active?
    !!@active
  end
end
