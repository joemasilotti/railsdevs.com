class AddInboundEmailTokenToConversations < ActiveRecord::Migration[7.0]
  def change
    add_column :conversations, :inbound_email_token, :string
    Conversation.find_each.map(&:regenerate_inbound_email_token)
    add_index :conversations, :inbound_email_token, unique: true
  end
end
