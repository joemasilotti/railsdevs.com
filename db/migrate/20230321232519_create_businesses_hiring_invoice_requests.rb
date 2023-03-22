class CreateBusinessesHiringInvoiceRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :businesses_hiring_invoice_requests do |t|
      t.belongs_to :business, foreign_key: true
      t.text :billing_address
      t.string :developer_name
      t.string :position
      t.date :start_date
      t.integer :annual_salary
      t.integer :employment_type
      t.text :feedback
      t.timestamps
    end
  end
end
