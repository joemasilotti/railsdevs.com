class Message < ApplicationRecord
  include Messages::Notifications

  FORMAT = AutoHtml::Pipeline.new(
    AutoHtml::HtmlEscape.new,
    AutoHtml::Link.new(target: "_blank"),
    AutoHtml::SimpleFormat.new
  )

  belongs_to :conversation, touch: true
  belongs_to :sender, polymorphic: true
  has_one :developer, through: :conversation
  has_one :business, through: :conversation

  has_noticed_notifications

  validates :body, presence: true
  validates :hiring_fee_agreement, acceptance: true

  scope :from_developer, -> { where(sender_type: Developer.name) }
  scope :potential_email, -> { where("body LIKE ?", "%@%") }

  def self.first_message?(developer)
    joins(:conversation).where(conversation: {developer:}).one?
  end

  def sender?(user)
    [user.developer, user.business].include?(sender)
  end

  def recipient
    if sender == developer
      business
    elsif sender == business
      developer
    end
  end

  def latest_notification_for_recipient(recipient)
    notifications_as_message.where(recipient:).last
  end

  def body=(text)
    super(text)
    self[:body_html] = FORMAT.call(text)
  end
end
