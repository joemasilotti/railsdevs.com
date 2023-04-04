class CreateAnalyticsSearcheQueries < ActiveRecord::Migration[7.0]
  def change
    create_table :analytics_search_queries do |t|
      t.string :search_query
      t.integer :specialty_ids, array: true, null: false, default: []
      t.string :badges, array: true, null: false, default: []
      t.string :role_levels, array: true, null: false, default: []
      t.string :role_types, array: true, null: false, default: []
      t.boolean :include_not_interested
      t.string :countries, array: true, null: false, default: []
      t.integer :utc_offsets
      t.string :sort
      t.integer :page

      t.timestamps
    end
  end
end
