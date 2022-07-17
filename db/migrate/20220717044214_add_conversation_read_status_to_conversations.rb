class AddConversationReadStatusToConversations < ActiveRecord::Migration[7.0]
  def change
    add_column :conversations, :read_status, :integer
  end
end
