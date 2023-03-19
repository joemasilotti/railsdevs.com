class Developers::CountriesQueryItem

  attr_reader :countries, :type

  def initialize(countries = [])
    @countries = countries
    @type = { countries: }
  end

  def query
    if countries.any?
      Developer.filter_by_countries(countries)
    end
  end

  def countries
    @countries.to_a.reject(&:blank?)
  end
end