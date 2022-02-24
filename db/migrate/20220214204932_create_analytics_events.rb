class CreateAnalyticsEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :analytics_events do |t|
      t.string :url, null: false
      t.string :goal, null: false
      t.integer :value, null: false, default: 0
      t.timestamp :tracked_at

      t.timestamps
    end
  end
end
