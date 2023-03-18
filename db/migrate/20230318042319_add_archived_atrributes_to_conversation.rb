class AddArchivedAtrributesToConversation < ActiveRecord::Migration[7.0]
  def change
    add_column :conversations, :developer_archived_at, :datetime
    add_column :conversations, :business_archived_at, :datetime
  end
end
