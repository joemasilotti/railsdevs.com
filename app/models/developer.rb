class Developer < ApplicationRecord
  include Availability
  include Avatarable
  extend FriendlyId
  friendly_id :randomizer, use: :slugged

  enum search_status: {
    actively_looking: 1,
    open: 2,
    not_interested: 3
  }

  serialize :pivot_skills
  serialize :technical_skills

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
  validates :github, {not_url: true}
  validates :twitter, {not_url: true}
  validates :linkedin, {not_url: true}

  @skills_regex = /^[-\w\s]+(?:,[-\w\s]*)*$/i

  validates :technical_skills, format: {with: @skills_regex, multiline: true}

  validates :pivot_skills, format: {with: @skills_regex, multiline: true}

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

  private

  def send_admin_notification
    NewDeveloperProfileNotification.with(developer: self).deliver_later(User.admin)
  end

  def randomizer
    Digest::SHA1.hexdigest("#{name} #{id}")[0..8]
  end
end
