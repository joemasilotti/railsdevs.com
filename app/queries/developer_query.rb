class DeveloperQuery
  include Pagy::Backend

  alias_method :build_pagy, :pagy

  attr_reader :options

  def initialize(options = {})
    @options = options
    @sort = options.delete(:sort)
    @time_zones = options.delete(:time_zones)
    @role_types = options.delete(:role_types)
  end

  def filters
    @filters = {sort:, time_zones:, role_types:}
  end

  def pagy
    @pagy ||= initialize_pagy_and_developers.first
  end

  def records
    @records ||= initialize_pagy_and_developers.last
  end

  def sort
    @sort.to_s.downcase.to_sym == :availability ? :availability : :newest
  end

  def time_zones
    @time_zones.to_a.reject(&:blank?)
  end

  def role_types
    @role_types.to_a.reject(&:blank?).map(&:to_sym)
  end

  private

  def initialize_pagy_and_developers
    @_records = Developer.includes(:role_type).with_attached_avatar
    sort_records
    time_zone_filter_records
    role_type_filter_records
    @pagy, @records = build_pagy(@_records)
  end

  def sort_records
    if sort == :availability
      @_records.merge!(Developer.available_first)
    else
      @_records.merge!(Developer.newest_first)
    end
  end

  def time_zone_filter_records
    if utc_offsets.any?
      @_records.merge!(Developer.filter_by_utc_offset(utc_offsets))
    end
  end

  def role_type_filter_records
    @_records.merge!(Developer.filter_by_role_types(role_types)) if role_types.any?
  end

  def utc_offsets
    time_zones.map { |tz| tz.to_f * SECONDS_IN_AN_HOUR }
  end

  # Needed for #pagy (aliased to #build_pagy) helper.
  def params
    options
  end
end
