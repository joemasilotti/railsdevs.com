class AddManualFlagToOpenStartupRevenues < ActiveRecord::Migration[7.0]
  def change
    add_column :open_startup_revenue, :manual, :boolean, null: false, default: false
  end
end
