class Developer < ApplicationRecord
  include Availability
  include Avatarable

  enum search_status: {
    actively_looking: 1,
    open: 2,
    not_interested: 3
  }

  belongs_to :user
  has_many :conversations, -> { visible }
  has_one :role_type, dependent: :destroy, autosave: true
  has_one_attached :cover_image

  accepts_nested_attributes_for :role_type

  validates :name, presence: true
  validates :hero, presence: true
  validates :bio, presence: true
  validates :cover_image, content_type: ["image/png", "image/jpeg", "image/jpg"],
    max_file_size: 10.megabytes
  validates :preferred_max_hourly_rate, allow_nil: true, numericality: {greater_than_or_equal_to: :preferred_min_hourly_rate}, if: -> { preferred_min_hourly_rate.present? }
  validates :preferred_max_salary, allow_nil: true, numericality: {greater_than_or_equal_to: :preferred_min_salary}, if: -> { preferred_min_salary.present? }

  scope :filter_by_utc_offset, ->(utc_offset) { where(utc_offset: utc_offset) }
  scope :filter_by_hourly_rate, ->(hourly_rate) { where(preferred_min_hourly_rate: ..hourly_rate) }
  scope :filter_by_salary, ->(salary) { where(preferred_min_salary: ..salary) }

  scope :available, -> { where(available_on: ..Time.current.to_date) }
  scope :newest_first, -> { order(created_at: :desc) }
  scope :available_first, -> { where.not(available_on: nil).order(:available_on) }

  after_create_commit :send_admin_notification

  def role_type
    super || build_role_type
  end

  def preferred_salary_range
    [preferred_min_salary, preferred_max_salary].compact
  end

  def preferred_hourly_rate_range
    [preferred_min_hourly_rate, preferred_max_hourly_rate].compact
  end

  private

  def send_admin_notification
    NewDeveloperProfileNotification.with(developer: self).deliver_later(User.admin)
  end
end
