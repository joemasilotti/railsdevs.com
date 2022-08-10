class AddUserWithUnreadMessagesColumnToConversations < ActiveRecord::Migration[7.0]
  def change
    add_column :conversations, :user_with_unread_messages_id, :integer
  end
end
