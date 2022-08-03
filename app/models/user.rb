class User < ApplicationRecord
  include APIAuthenticatable
  include PayCustomer

  devise :confirmable,
    :database_authenticatable,
    :recoverable,
    :registerable,
    :rememberable,
    :validatable

  has_many :notification_tokens
  has_many :notifications, as: :recipient, dependent: :destroy
  has_one :business, dependent: :destroy
  has_one :developer, dependent: :destroy

  has_many :conversations, ->(user) {
    unscope(where: :user_id)
      .left_joins(:business, :developer)
      .where("businesses.user_id = ? OR developers.user_id = ?", user.id, user.id)
      .visible
  }

  scope :admin, -> { where(admin: true) }

  # Always remember when signing in with Devise.
  def remember_me
    Rails.configuration.always_remember_me
  end

  def conversations_with_read_status
    conversations = self.conversations.order(updated_at: :desc).to_a
    # Computing
    notifications_as_aj_serialized = conversations.reduce(Set.new) do |accu, conversation|
      serialized_aj_id = ActiveJob::Arguments.send(:serialize_argument, conversation)
      accu.add serialized_aj_id['_aj_globalid']
    end

    notifications = Notification
                    .select("DISTINCT RIGHT(params->'conversation'->>'_aj_globalid', 1) as conversation_id, recipient_id, recipient_type, read_at")
                    .where("params->'conversation'->>'_aj_globalid' IN (#{notifications_as_aj_serialized.map{|x|"'#{x}'"}.join(', ')})")
                    .where(
                      recipient: self,
                      read_at: nil
                    )
    # An array in memory
    notifications.each do |notification|
      convo = conversations.find { |conversation| conversation.id == notification.conversation_id.to_i }
      next if convo.nil?

      convo.read_by_current_user = true
    end
    conversations
  end
end
# railsdevs_development=# SELECT * from notifications WHERE notifications.params->'conversation'->>'_aj_globalid' IN ('gid://railsdevs/Conversation/1'::text);
# railsdevs_development=# SELECT * from notifications WHERE notifications.params->'conversation'->>'_aj_globalid' IN ('gid://railsdevs/Conversation/1', 'gid://railsdevs/Conversation/2');