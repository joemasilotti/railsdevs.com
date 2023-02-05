class ReworkReferrals < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :referral_code, :string
    add_reference :referrals, :referrer
  end
end
