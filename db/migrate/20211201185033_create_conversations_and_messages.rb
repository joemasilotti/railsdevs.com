class CreateConversationsAndMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :conversations do |t|
      t.belongs_to :developer
      t.belongs_to :business

      t.timestamps
    end

    create_table :messages do |t|
      t.belongs_to :conversation
      t.references :sender, polymorphic: true
      t.text :body, null: false

      t.timestamps
    end
  end
end
