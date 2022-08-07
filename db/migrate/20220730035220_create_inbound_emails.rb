class CreateInboundEmails < ActiveRecord::Migration[7.0]
  def change
    create_table :inbound_emails do |t|
      t.belongs_to :message
      t.string :postmark_message_id, null: false
      t.jsonb :payload, null: false

      t.timestamps
    end
  end
end
