class Message < ApplicationRecord
  FORMAT = AutoHtml::Pipeline.new(
    AutoHtml::HtmlEscape.new,
    AutoHtml::Link.new(target: "_blank"),
    AutoHtml::SimpleFormat.new
  )

  belongs_to :conversation
  belongs_to :sender, polymorphic: true
  has_one :developer, through: :conversation
  has_one :business, through: :conversation

  has_noticed_notifications

  validates :body, presence: true

  after_create_commit :send_recipient_notification

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

  def body=(text)
    super(text)
    self[:body_html] = FORMAT.call(text)
  end

  private

  def send_recipient_notification
    NewMessageNotification.with(message: self, conversation:).deliver_later(recipient.user)
  end
end
