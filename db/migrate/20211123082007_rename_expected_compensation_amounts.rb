class RenameExpectedCompensationAmounts < ActiveRecord::Migration[7.0]
  def change
    rename_column :developers, :expected_hourly_rate, :preferred_min_hourly_rate
    rename_column :developers, :expected_salary, :preferred_min_salary
  end
end
