class ChangeTimeZoneToPrimaryTimeZone < ActiveRecord::Migration[7.0]
  def change
    rename_column :developers, :time_zone, :primary_time_zone
  end
end
