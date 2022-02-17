class CreateLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :locations do |t|
      t.belongs_to :developer

      t.string :city, null: false
      t.string :state
      t.string :country, null: false
      t.string :country_code, null: false
      t.decimal :latitude, null: false
      t.decimal :longitude, null: false
      t.string :timezone, null: false
      t.jsonb :data, null: false

      t.timestamps
    end
  end
end
