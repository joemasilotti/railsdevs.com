class ExpectedCompensationComponent < ApplicationComponent
  attr_reader :developer

  def initialize(developer)
    @developer = developer
  end

  def render?
    @developer.preferred_min_hourly_rate.present? || @developer.preferred_min_salary.present?
  end
end
