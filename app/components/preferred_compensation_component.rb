class PreferredCompensationComponent < ApplicationComponent
  attr_reader :developer

  def initialize(developer)
    @developer = developer
  end

  def render?
    developer.preferred_hourly_rate_range.present? || developer.preferred_salary_range.present?
  end
end
