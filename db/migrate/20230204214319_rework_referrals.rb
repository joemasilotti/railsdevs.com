class ReworkReferrals < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :referral_code, :string

    rename_column :referrals, :user_id, :referred_user_id
    add_reference :referrals, :referring_user
  end
end
