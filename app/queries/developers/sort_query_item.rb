class Developers::SortQueryItem

  attr_reader :sort, :type

  def initialize(sort = nil)
    @sort = sort
    @type = { sort: }
  end

  def query
    if sort == :availability
      Developer.available_first
    else
      Developer.newest_first
    end
  end

  def sort
    @sort.to_s.downcase.to_sym == :availability ? :availability : :newest
  end
end