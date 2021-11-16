class CreateConversations < ActiveRecord::Migration[7.0]
  def change
    create_table :conversations do |t|
      t.references :developer, null: false, foreign_key: {to_table: :users}
      t.references :client, null: false, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
