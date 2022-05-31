class DeveloperQuerySortButtonComponent < ApplicationComponent
  attr_reader :query, :user

  delegate :sort, :search_query, to: :query

  def initialize(query:, user:)
    @query = query
    @user = user
  end
end
