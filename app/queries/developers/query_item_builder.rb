class Developers::QueryItemBuilder

  attr_reader :query_items, :options

  QUERY_ITEM_OPTIONS = %i[sort countries]

  def initialize(options = {})
    @options = options
    @query_items = []
  end

  def build_query_items
    add_sorting_query
    add_countries_filter_query

    query_items
  end

  def add_sorting_query
    query_items << Developers::SortQueryItem.new(options[:sort])
  end

  def add_countries_filter_query
    query_items << Developers::CountriesQueryItem.new(options[:countries])
  end

  # defines query item methods like sort_query_item, countries_query_item
  # which can give us the respective query item object
  # example: query_item_builder.sort_query_item
  QUERY_ITEM_OPTIONS.each do |method_initial, _|
    define_method "#{method_initial}_query_item" do
      query_items.detect { |query_item| query_item.type.has_key? method_initial }
    end
  end
end