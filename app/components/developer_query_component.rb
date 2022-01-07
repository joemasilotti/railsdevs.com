class DeveloperQueryComponent < ApplicationComponent
  attr_reader :query

  def initialize(query)
    @query = query
  end

  def sort
    query.sort
  end

  def time_zones
    Developer.where.not(time_zone: [nil, ""]).map { |d| ActiveSupport::TimeZone.new(d.time_zone).utc_offset / 3600 }.uniq.sort
  end
end
