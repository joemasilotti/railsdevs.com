class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.belongs_to :profile, polymorphic: true, null: false

      t.timestamps
    end

    create_table :account_memberships do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :account, null: false, foreign_key: true

      t.string :role, default: "admin", index: true

      t.timestamps
    end

    # TODO: Write a test to ensure the correct account is migrated.
    [Business, Developer].each do |model|
      model.in_batches do |batch|
        account_attrs = batch.map do |business|
          {
            profile_id: business.id,
            profile_type: model
          }
        end

        accounts = Account.insert_all(
          account_attrs, returning: %w[profile_id id]
        ).rows.to_h

        membership_attrs = batch.map do |business|
          {
            user_id: business.user_id,
            account_id: accounts[business.id]
          }
        end

        AccountMembership.insert_all(membership_attrs)
      end
    end
  end
end
