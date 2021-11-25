class AddPreferredMaxHourlyRateToDevelopers < ActiveRecord::Migration[7.0]
  def change
    add_column :developers, :preferred_max_hourly_rate, :integer
  end
end
