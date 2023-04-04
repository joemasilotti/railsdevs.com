class AddCounterCacheToUserReferrals < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :referrals_count, :integer, null: false, default: 0

    User.find_each { |u| User.reset_counters(u.id, :referrals) }
  end
end
