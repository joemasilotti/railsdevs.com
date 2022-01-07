class DeveloperQueryComponent < ApplicationComponent
  attr_reader :query

  def initialize(query)
    @query = query
  end

  def sort
    query.sort
  end
end
