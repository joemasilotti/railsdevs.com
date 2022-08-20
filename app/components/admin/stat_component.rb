module Admin
  class StatComponent < ApplicationComponent
    attr_reader :title, :icon, :percentage, :secondary_value

    def initialize(title:, value:, icon:, percentage: false, secondary_value: nil)
      @title = title
      @value = value
      @icon = icon
      @percentage = percentage
      @secondary_value = secondary_value
    end

    def value
      if percentage
        "#{(@value * 100).round}%"
      else
        @value
      end
    end
  end
end
