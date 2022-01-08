class DeveloperQuery
  include Pagy::Backend

  alias_method :build_pagy, :pagy

  attr_reader :options

  def initialize(options = {})
    @options = options
    @sort = options.delete(:sort)
    @hourly_rate = options.delete(:hourly_rate)
    @salary = options.delete(:salary)
    @time_zones = options.delete(:time_zones)
  end

  def pagy
    @pagy ||= initialize_pagy.first
  end

  def records
    @records ||= initialize_pagy.last
  end

  def sort
    @sort.to_s.downcase.to_sym == :availability ? :availability : :newest
  end

  def hourly_rate
    hourly_rate = @hourly_rate.to_i
    hourly_rate > 0 ? hourly_rate : nil
  end

  def salary
    salary = @salary.to_i
    salary > 0 ? salary : nil
  end

  def time_zones
    @time_zones.to_a.reject(&:blank?)
  end

  private

  def initialize_pagy
    records = Developer.includes(:role_type).with_attached_avatar
    records = sorted(records)
    records = time_zone_filtered(records)
    records = hourly_rate_filtered(records)
    records = salary_filtered(records)
    @pagy, @records = build_pagy(records)
  end

  def sorted(records)
    if sort == :availability
      records.merge(Developer.available_first)
    else
      records.merge(Developer.newest_first)
    end
  end

  def time_zone_filtered(records)
    if utc_offsets.any?
      records.merge(Developer.filter_by_utc_offset(utc_offsets))
    else
      records
    end
  end

  def hourly_rate_filtered(records)
    if hourly_rate.present?
      records.merge(Developer.filter_by_hourly_rate(hourly_rate))
    else
      records
    end
  end

  def salary_filtered(records)
    if salary.present?
      records.merge(Developer.filter_by_salary(salary))
    else
      records
    end
  end

  def utc_offsets
    time_zones.map { |tz| tz.to_f * SECONDS_IN_AN_HOUR }
  end

  # Needed for #pagy (aliased to #build_pagy) helper.
  def params
    options
  end
end
