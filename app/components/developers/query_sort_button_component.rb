module Developers
  class QuerySortButtonComponent < ApplicationComponent
    attr_reader :query, :user, :form_id

    delegate :sort, :search_query, to: :query

    def initialize(query:, user:, form_id:)
      @query = query
      @user = user
      @form_id = form_id
    end
  end
end
