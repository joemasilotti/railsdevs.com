class CreateNotificationTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :notification_tokens do |t|
      t.string :platform, null: false
      t.string :token, null: false
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
