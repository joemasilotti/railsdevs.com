class CreateBusinessesHiringInvoiceRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :businesses_hiring_invoice_requests do |t|
      t.belongs_to :business, null: false, foreign_key: true
      t.text :billing_address, null: false
      t.string :developer_name, null: false
      t.date :start_date, null: false
      t.integer :annual_salary, null: false
      t.integer :employment_type, null: false
      t.string :position
      t.text :feedback
      t.timestamps
    end
  end
end
