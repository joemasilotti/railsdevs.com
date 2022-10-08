class AddUniqueIndexToConversations < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def change
    add_index :conversations, [:developer_id, :business_id], unique: true, algorithm: :concurrently
  end
end
