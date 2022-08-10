class AddTemporaryOpenStartupMetricMigrationColumn < ActiveRecord::Migration[7.0]
  def change
    add_column :open_startup_metrics, :data_json, :jsonb
  end
end
