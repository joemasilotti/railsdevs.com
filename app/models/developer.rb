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
  validates :avatar, content_type: ["image/png", "image/jpg", "image/jpeg"],
    max_file_size: 2.megabytes
  validates :cover_image, content_type: ["image/png", "image/jpg", "image/jpeg", "image/gif"],
    max_file_size: 10.megabytes
  validates :preferred_max_hourly_rate, allow_nil: true, numericality: {greater_than_or_equal_to: :preferred_min_hourly_rate}, if: -> { preferred_min_hourly_rate.present? }
  validates :preferred_max_salary, allow_nil: true, numericality: {greater_than_or_equal_to: :preferred_min_salary}, if: -> { preferred_min_salary.present? }

  scope :available, -> { where("available_on <= ?", Date.today) }
  scope :most_recently_added, -> { order(created_at: :desc) }

  after_initialize :build_role_type, if: -> { role_type.blank? }
  after_create :send_admin_notification

  def preferred_salary_range
    [preferred_min_salary, preferred_max_salary].compact
  end

  def preferred_hourly_rate_range
    [preferred_min_hourly_rate, preferred_max_hourly_rate].compact
  end

  def send_admin_notification
    NewDeveloperProfileNotification.with(developer: self).deliver_later(User.admin)
  end
end
