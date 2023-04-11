class AddCounterCacheToDeveloperConversations < ActiveRecord::Migration[7.0]
  def change
    add_column :developers, :conversations_count, :integer, null: false, default: 0

    Developer.find_each { |d| Developer.reset_counters(d.id, :conversations) }
  end
end
