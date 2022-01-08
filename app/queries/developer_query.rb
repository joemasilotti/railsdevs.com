class DeveloperQuery
  include Pagy::Backend

  alias_method :build_pagy, :pagy

  attr_reader :options

  def initialize(options = {})
    @options = options
    @sort = options.delete(:sort)
  end

  def pagy
    @pagy ||= initialize_pagy.first
  end

  def records
    @records ||= initialize_pagy.last
  end

  def sort
    @sort = @sort.to_s.downcase.to_sym
    @sort == :availability ? :availability : :newest
  end

  private

  def initialize_pagy
    records = Developer.includes(:role_type).with_attached_avatar
    records = sorted(records)
    @pagy, @records = build_pagy(records)
  end

  def sorted(records)
    if sort == :availability
      records.merge(Developer.available_first)
    else
      records.merge(Developer.newest_first)
    end
  end

  # Needed for #pagy (aliased to #build_pagy) helper.
  def params
    options
  end
end
