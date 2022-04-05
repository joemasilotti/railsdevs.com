class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.belongs_to :owner

      t.timestamps
    end

    create_table :account_users do |t|
      t.belongs_to :account
      t.belongs_to :user
      t.integer :role, null: false

      t.timestamps
    end

    add_belongs_to :developers, :account
    add_belongs_to :businesses, :account
  end
end
