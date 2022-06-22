class Business < ApplicationRecord
  include Avatarable
  include Businesses::Notifications
  include PersonName
  include PgSearch::Model

  enum :developer_notifications, %i[no daily weekly], default: :no, suffix: true

  belongs_to :user
  has_many :conversations, -> { visible }

  has_noticed_notifications

  validates :contact_name, presence: true
  validates :company, presence: true
  validates :bio, presence: true
  validates :developer_notifications, inclusion: {in: developer_notifications.keys}

  scope :newest_first, -> { order(created_at: :desc) }

  pg_search_scope :filter_by_search_query, against: [:company, :contact_name], associated_against: {user: :email}, using: {tsearch: {prefix: true}}

  alias_attribute :name, :contact_name
end
