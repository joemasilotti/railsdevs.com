class RemoveTimeZoneAndUTCOffsetFromDevelopers < ActiveRecord::Migration[7.0]
  def change
    remove_column :developers, :time_zone, :string
    remove_column :developers, :utc_offset, :integer
  end
end
