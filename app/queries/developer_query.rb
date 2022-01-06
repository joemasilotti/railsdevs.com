class DeveloperQuery
  include Pagy::Backend

  alias_method :build_pagy, :pagy

  attr_reader :options

  def initialize(options = {})
    @options = options
    @available = ActiveModel::Type::Boolean.new.cast(options[:available])
  end

  def available?
    @available
  end

  def pagy
    @pagy ||= initialize_pagy.first
  end

  def records
    @records ||= initialize_pagy.last
  end

  private

  def initialize_pagy
    records = Developer
      .includes(:role_type).with_attached_avatar
      .most_recently_added
    records = records.available if available?

    @pagy, @records = build_pagy(records)
  end

  # Needed for #pagy (aliased to #build_pagy) helper.
  def params
    options
  end
end
