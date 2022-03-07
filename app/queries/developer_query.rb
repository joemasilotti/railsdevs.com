class DeveloperQuery
  include Pagy::Backend

  alias_method :build_pagy, :pagy

  attr_reader :options

  def initialize(options = {})
    @options = options
    @sort = options.delete(:sort)
    @utc_offsets = options.delete(:utc_offsets)
    @role_types = options.delete(:role_types)
    @role_levels = options.delete(:role_levels)
    @include_not_interested = options.delete(:include_not_interested)
  end

  def filters
    @filters = {sort:, utc_offsets:, role_types:, role_levels:, include_not_interested:}
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

  def utc_offsets
    @utc_offsets.to_a.reject(&:blank?).map(&:to_f)
  end

  def role_types
    @role_types.to_a.reject(&:blank?).map(&:to_sym)
  end

  def role_levels
    @role_levels.to_a.reject(&:blank?).map(&:to_sym)
  end

  def include_not_interested
    ActiveModel::Type::Boolean.new.cast(@include_not_interested)
  end

  private

  def initialize_pagy_and_developers
    @_records = Developer.includes(:role_type).with_attached_avatar.visible
    sort_records
    utc_offset_filter_records
    role_type_filter_records
    role_level_filter_records
    search_status_filter_records
    @pagy, @records = build_pagy(@_records)
  end

  def sort_records
    if sort == :availability
      @_records.merge!(Developer.available_first)
    else
      @_records.merge!(Developer.newest_first)
    end
  end

  def utc_offset_filter_records
    if utc_offsets.any?
      @_records.merge!(Developer.filter_by_utc_offset(utc_offsets))
    end
  end

  def role_type_filter_records
    @_records.merge!(Developer.filter_by_role_types(role_types)) if role_types.any?
  end

  def role_level_filter_records
    @_records.merge!(Developer.filter_by_role_levels(role_levels)) if role_levels.any?
  end

  def search_status_filter_records
    @_records.merge!(Developer.actively_looking.or(Developer.open)) unless include_not_interested
  end

  # Needed for #pagy (aliased to #build_pagy) helper.
  def params
    options
  end
end
