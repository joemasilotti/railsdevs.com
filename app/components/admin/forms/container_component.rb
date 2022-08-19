class Admin::Forms::ContainerComponent < ApplicationComponent
  renders_one :button_group

  attr_reader :title, :description

  def initialize(title, description)
    @title = title
    @description = description
  end
end
