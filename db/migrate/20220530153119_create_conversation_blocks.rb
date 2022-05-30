class CreateConversationBlocks < ActiveRecord::Migration[7.0]
  def change
    create_table :conversation_blocks do |t|
      t.references :conversation
      t.references :blocker
      t.references :blockee

      t.timestamps
    end

    Conversation.where.not(business_blocked_at: nil).or(Conversation.where.not(developer_blocked_at: nil)).find_each do |conversation|
      if conversation.business_blocked_at?
        Conversation::Block.create! conversation:, blocker: conversation.business.user, blockee: conversation.developer.user, created_at: conversation.business_blocked_at
      elsif conversation.developer_blocked_at?
        Conversation::Block.create! conversation:, blocker: conversation.developer.user, blockee: conversation.business.user, created_at: conversation.developer_blocked_at
      end
    end
  end
end
