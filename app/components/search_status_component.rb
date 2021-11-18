class SearchStatusComponent < ApplicationComponent
  def initialize(developer)
    @developer = developer
  end

  def humanize(enum_value)
    Developer.human_attribute_name "search_status.#{enum_value}"
  end
end
