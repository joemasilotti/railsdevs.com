class DeveloperQuery
  SEARCHABLE_OPTIONS = %i(utc_offsets role_types role_levels include_not_interested search_query countries badges specialty_ids)

  # Those options seem like they should not be exposed directly as a part of DeveloperQuery
  # and better be a part of some presenter or accessed through options hash
  # Howerver currently many implementations depend on those public methods so we describe them explicitly
  EXPOSED_OPTIONS = %i(countries utc_offsets role_types role_levels badges specialty_ids include_not_interested search_query)

  include Pagy::Backend

  alias_method :build_pagy, :pagy

  attr_reader :options

  def initialize(options = {})
    @options = options
    @ransack_params_builder = DeveloperQueryRansackParamsBuilder.new
    @items_per_page = options.delete(:items_per_page)
    @user = options.delete(:user)
  end

  # Different options that are public methods which external components depend on
  # also have different rules of presentation which would be better a part of a 
  # specific presenter class
  EXPOSED_OPTIONS.each do |opt|
    define_method(opt) do
      case opt
      when :countries, :specialty_ids
        Array.wrap(options[opt]).reject(&:blank?)
      when :role_types, :role_levels, :badges
        Array.wrap(options[opt]).reject(&:blank?).map(&:to_sym)
      when :utc_offsets
        Array.wrap(options[opt]).reject(&:blank?).map(&:to_f)
      when :search_query
        options[opt].to_s.strip
      when :include_not_interested
        ActiveModel::Type::Boolean.new.cast(options[opt])
      else
        options[opt]
      end
    end
  end

  def filters
    @filters ||= begin
      # For some reason currently there are no explicit filters for specialties
      # and building filters like this make this detail visible
      filters_options = SEARCHABLE_OPTIONS - [:specialty_ids] + [:sort]
      options.slice(*filters_options).to_h
    end
  end

  def pagy
    @pagy ||= query_and_paginate.first
  end

  def records
    @records ||= query_and_paginate.last
  end

  def featured_records
    if pagy.page == 1 && empty_search?
      @featured_records ||= Developer.featured
    else
      Developer.none
    end
  end

  def sort
    options[:sort].to_s.downcase.to_sym == :availability ? :availability : :newest
  end

  private

  def query_and_paginate
    base_scope = Developer.with_attached_avatar.visible.includes(:role_type, :specialties)
    ransack_params = @ransack_params_builder.call(options)
    @_records = base_scope.ransack(ransack_params).result(distinct: true)

    @pagy, @records = build_pagy(@_records, items: items_per_page)
  end

  def items_per_page
    @items_per_page || Pagy::DEFAULT[:items]
  end

  def empty_search?
    SEARCHABLE_OPTIONS.all? { |opt| options[opt].blank? }
  end

  # Needed for #pagy (aliased to #build_pagy) helper.
  def params
    options
  end
end
