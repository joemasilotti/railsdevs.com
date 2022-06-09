class CreateConversationBlocks < ActiveRecord::Migration[7.0]
  def change
    create_table :conversation_blocks do |t|
      t.references :conversation, null: false
      t.references :blocker, null: false
      t.references :blockee, null: false

      t.timestamps
    end
  end
end
