module Admin
  class BusinessesContext
    attr_reader :title, :search_query

    def initialize(title:, search_query:)
      @title = title
      @search_query = search_query
    end

    def query
      @query ||= BusinessQuery.new(search_query:)
    end

    def stats
      @stats ||= Stats::Business.new(query.all_records)
    end
  end
end
