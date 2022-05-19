module Admin
  class DevelopersContext
    attr_reader :title, :search_query

    def initialize(title:, search_query:)
      @title = title
      @search_query = search_query
    end

    def query
      @query ||= DeveloperQuery.new({search_query:, include_not_interested: true, search_type: :name_and_email})
    end

    def stats
      @stats ||= Stats::Developer.new(query.all_records)
    end
  end
end
