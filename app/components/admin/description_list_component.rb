module Admin
  class DescriptionListComponent < ApplicationComponent
    renders_one :link, Admin::LinkComponent
    renders_many :descriptions, Admin::DescriptionComponent

    attr_reader :title, :description

    def initialize(title, description = nil)
      @title = title
      @description = description
    end
  end
end
