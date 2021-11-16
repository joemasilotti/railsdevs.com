class AddIndexToConversation < ActiveRecord::Migration[7.0]
  def change
    add_index :conversations, [:client_id, :developer_id], unique: true
  end
end
