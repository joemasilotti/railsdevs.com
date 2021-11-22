class ExpectedCompensationComponent < ApplicationComponent
  attr_reader :developer

  def initialize(developer)
    @developer = developer
  end

  def render?
    @developer.expected_hourly_rate.present? || @developer.expected_salary.present?
  end
end
