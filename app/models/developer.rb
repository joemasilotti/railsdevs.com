class Developer < ApplicationRecord
  include Availability

  enum search_status: {
    actively_looking: 1,
    open: 2,
    not_interested: 3
  }

  belongs_to :user
  has_one :role_type, dependent: :destroy, autosave: true
  has_one_attached :avatar
  has_one_attached :cover_image

  accepts_nested_attributes_for :role_type

  validates :name, presence: true
  validates :hero, presence: true
  validates :bio, presence: true
  validates :avatar, content_type: ["image/png", "image/jpg", "image/jpeg"],
    max_file_size: 2.megabytes
  validates :cover_image, content_type: ["image/png", "image/jpg", "image/jpeg", "image/gif"],
    max_file_size: 10.megabytes

  validates_numericality_of :preferred_min_hourly_rate, less_than: ->(developer) { developer.preferred_max_hourly_rate }, if: -> { preferred_min_hourly_rate.present? }
  validates_numericality_of :preferred_max_hourly_rate, greater_than: ->(developer) { developer.preferred_min_hourly_rate }, if: -> { preferred_max_hourly_rate.present? }
  validates_numericality_of :preferred_min_salary, less_than: ->(developer) { developer.preferred_max_salary }, if: -> { preferred_min_salary.present? }
  validates_numericality_of :preferred_max_salary, greater_than: ->(developer) { developer.preferred_min_salary }, if: -> { preferred_max_salary.present? }

  scope :available, -> { where("available_on <= ?", Date.today) }
  scope :most_recently_added, -> { order(created_at: :desc) }

  after_initialize :build_role_type, if: -> { role_type.blank? }
end
