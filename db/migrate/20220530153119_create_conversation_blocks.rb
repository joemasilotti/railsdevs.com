class CreateConversationBlocks < ActiveRecord::Migration[7.0]
  def change
    create_table :conversation_blocks do |t|
      t.references :conversation
      t.references :blocker
      t.references :blockee

      t.timestamps
    end
  end
end
