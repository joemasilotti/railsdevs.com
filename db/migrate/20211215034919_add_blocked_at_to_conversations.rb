class AddBlockedAtToConversations < ActiveRecord::Migration[7.0]
  def change
    add_column :conversations, :developer_blocked_at, :datetime
    add_column :conversations, :business_blocked_at, :datetime
  end
end
