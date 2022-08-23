class CreateHiredForms < ActiveRecord::Migration[7.0]
  def change
    create_table :hired_forms do |t|
      t.belongs_to :developer, null: false, foreign_key: true
      t.text :address, null: false
      t.string :company, null: false
      t.string :position, null: false
      t.date :start_date, null: false
      t.integer :employment_type, null: false
      t.text :feedback

      t.timestamps
    end
  end
end
