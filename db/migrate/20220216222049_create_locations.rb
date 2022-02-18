class CreateLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :locations do |t|
      t.belongs_to :developer

      t.string :city
      t.string :state
      t.string :country
      t.string :country_code
      t.decimal :latitude
      t.decimal :longitude
      t.string :time_zone, null: false
      t.integer :utc_offset, null: false
      t.jsonb :data

      t.timestamps
    end
  end
end
