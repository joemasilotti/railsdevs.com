class Developers::QueryItemBuilder

  attr_reader :query_items, :options

  def initialize(options = {})
    options[:countries] = [] unless options.has_key?(:countries)
    options[:sort] = nil unless options.has_key?(:sort)
    @options = options
    @query_items = []

    options.each do |query_item_type, query_item_value|
      query_item_type = query_item_type.to_s.capitalize
      query_items << "Developers::#{query_item_type}QueryItem".constantize.new(query_item_value)
    end
  end
end