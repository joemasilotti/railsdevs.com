class CreateOffers < ActiveRecord::Migration[7.0]
  def change
    create_table :offers do |t|
      t.references :conversation, null: false
      t.date :start_date
      t.float :pay_rate_value
      t.integer :pay_rate_time_unit
      t.text :comment

      t.timestamps
    end
  end
end
