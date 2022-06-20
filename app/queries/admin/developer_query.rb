module Admin
  class DeveloperQuery
    include Pagy::Backend

    alias_method :build_pagy, :pagy

    attr_reader :options

    def initialize(options = {})
      @options = options
      @items_per_page = options.delete(:items_per_page)
      @search_query = options.delete(:search_query)
    end

    def pagy
      @pagy ||= query_and_paginate.first
    end

    def records
      @records ||= query_and_paginate.last
    end

    def all_records
      @all_records || Developer.all
    end

    def search_query
      @search_query.to_s.strip
    end

    private

    def query_and_paginate
      @_records = Developer.with_attached_avatar.visible
      sort_records
      search_query_filter_records
      @pagy, @records = build_pagy(@_records, items: items_per_page)
    end

    def items_per_page
      @items_per_page || Pagy::DEFAULT[:items]
    end

    def sort_records
      @_records.merge!(Developer.newest_first)
    end

    def search_query_filter_records
      @_records.merge!(Developer.filter_by_name(search_query)) unless search_query.empty?
    end

    # Needed for #pagy (aliased to #build_pagy) helper
    def params
      options
    end
  end
end
