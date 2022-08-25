class RemoveTemporaryOpenStartupMetricMigrationColumn < ActiveRecord::Migration[7.0]
  def change
    rename_column :open_startup_metrics, :data, :legacy_data
    rename_column :open_startup_metrics, :data_json, :data
    change_column_null :open_startup_metrics, :data, false
  end
end
