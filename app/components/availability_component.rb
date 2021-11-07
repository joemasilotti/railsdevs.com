# frozen_string_literal: true

class AvailabilityComponent < ViewComponent::Base
  def initialize(available_on:)
    @available_on = available_on
  end
end
