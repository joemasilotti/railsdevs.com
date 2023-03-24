module Developers
  class QuerySortButtonComponent < ApplicationComponent
    attr_reader :query, :sort_query_item, :user, :form_id, :scope

    delegate :search_query, to: :query
    delegate :sort, to: :sort_query_item

    def initialize(query:, user:, form_id:, scope: nil)
      @query = query
      @sort_query_item = query.query_items.detect { |query_item| query_item.type == :sort }
      @user = user
      @form_id = form_id
      @scope = scope
    end
  end
end
