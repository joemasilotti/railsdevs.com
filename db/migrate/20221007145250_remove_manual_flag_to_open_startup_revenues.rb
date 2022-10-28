class RemoveManualFlagToOpenStartupRevenues < ActiveRecord::Migration[7.0]
  def change
    remove_column :open_startup_revenue, :manual, :boolean, null: false, default: false
  end
end
