class AddBlockedAtToConversations < ActiveRecord::Migration[7.0]
  def change
    add_column :conversations, :blocked_by_developer_at, :datetime
    add_column :conversations, :blocked_by_business_at, :datetime
  end
end
