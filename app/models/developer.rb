class Developer < ApplicationRecord
  include Availability
  include Avatarable
  include Developers::Notifications
  include Developers::RichText
  include HasBadges
  include HasSocialProfiles
  include HasSpecialties
  include Hashid::Rails
  include PersonName
  include PgSearch::Model
  include PublicProfile

  FEATURE_LENGTH = 1.week

  enum search_status: {
    actively_looking: 1,
    open: 2,
    not_interested: 3,
    invisible: 4
  }

  belongs_to :user
  has_one :referring_user, through: :user
  has_many :conversations, -> { visible }
  has_many :messages, -> { where(sender_type: Developer.name) }, through: :conversations
  has_many :hired_forms, class_name: "Hired::Form", dependent: :destroy
  has_one :location, dependent: :destroy, autosave: true
  has_one :role_level, dependent: :destroy, autosave: true
  has_one :role_type, dependent: :destroy, autosave: true
  has_one_attached :cover_image

  has_noticed_notifications

  accepts_nested_attributes_for :location, reject_if: :all_blank, update_only: true
  accepts_nested_attributes_for :role_level, update_only: true
  accepts_nested_attributes_for :role_type, update_only: true

  validates :bio, presence: true
  validates :cover_image, content_type: ["image/png", "image/jpeg", "image/jpg"], max_file_size: 10.megabytes
  validates :hero, presence: true
  validates :location, presence: true, on: :create
  validates :name, presence: true
  validates :response_rate, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 100}

  pg_search_scope :filter_by_search_query, against: [:bio, :hero], associated_against: {specialties: :name}, using: {tsearch: {tsvector_column: :textsearchable_index_col, prefix: true}}

  delegate :email, to: :referring_user, prefix: true, allow_nil: true

  scope :filter_by_role_types, ->(role_types) do
    RoleType::TYPES.filter_map { |type|
      where(role_type: {type => true}) if role_types.include?(type)
    }.reduce(:or)&.joins(:role_type)
  end

  scope :filter_by_role_levels, ->(role_levels) do
    RoleLevel::TYPES.filter_map { |level|
      where(role_level: {level => true}) if role_levels.include?(level)
    }.reduce(:or)&.joins(:role_level)
  end

  scope :filter_by_utc_offsets, ->(utc_offsets) do
    joins(:location).where(locations: {utc_offset: utc_offsets})
  end

  scope :filter_by_countries, ->(countries) do
    joins(:location).where(locations: {country: countries})
  end

  scope :actively_looking_or_open, -> { where(search_status: [:actively_looking, :open, nil]) }
  scope :available, -> { where(available_on: ..Time.current.to_date) }
  scope :available_first, -> { where.not(available_on: nil).order(:available_on) }
  scope :featured, -> { where("featured_at >= ?", FEATURE_LENGTH.ago).order(featured_at: :desc) }
  scope :newest_first, -> { order(created_at: :desc) }
  scope :product_announcement_notifications, -> { where(product_announcement_notifications: true) }
  scope :profile_reminder_notifications, -> { where(profile_reminder_notifications: true) }
  scope :visible, -> { where.not(search_status: :invisible).or(where(search_status: nil)) }
  scope :with_specialty_ids, ->(specialty_ids) {
    where_sql = <<-SQL
      exists (
        select 1 from specialty_tags
        where specialty_tags.specialty_id in (?)
          and specialty_tags.developer_id = developers.id
      )
    SQL
    where(where_sql, Array.wrap(specialty_ids))
  }

  def visible?
    !invisible?
  end

  def location
    super || build_location
  end

  def role_level
    super || build_role_level
  end

  def role_type
    super || build_role_type
  end

  # If a check is added make sure to add a Developer::NewFieldComponent to the developer form.
  def missing_fields?
    search_status.blank? ||
      location.missing_fields? ||
      role_level.missing_fields? ||
      role_type.missing_fields? ||
      available_on.blank?
  end

  def feature!
    touch(:featured_at)
  end

  def featured?
    featured_at? && featured_at >= FEATURE_LENGTH.ago
  end
end
