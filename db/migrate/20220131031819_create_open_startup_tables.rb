class CreateOpenStartupTables < ActiveRecord::Migration[7.0]
  def change
    create_table :open_startup_transactions do |t|
      t.date :occurred_on, null: false
      t.string :description, null: false
      t.string :url
      t.decimal :amount, null: false
      t.integer :transaction_type, default: 1, null: false

      t.timestamps
    end

    create_table :open_startup_stripe_transactions do |t|
      t.string :stripe_id, null: false, index: true
      t.decimal :amount, null: false
      t.datetime :created, null: false
      t.string :description, null: false
      t.decimal :fee, null: false
      t.string :transaction_type, null: false, index: true

      t.timestamps
    end

    create_table :open_startup_revenue do |t|
      t.date :occurred_on, null: false
      t.string :description, null: false
      t.decimal :amount, null: false

      t.timestamps
    end

    create_table :open_startup_expenses do |t|
      t.date :occurred_on, null: false
      t.string :description, null: false
      t.string :url
      t.decimal :amount, null: false

      t.timestamps
    end

    create_table :open_startup_contributions do |t|
      t.date :occurred_on, null: false
      t.string :description, null: false
      t.string :url
      t.decimal :amount, null: false

      t.timestamps
    end

    create_table :open_startup_monthly_balances do |t|
      t.date :occurred_on, null: false
      t.decimal :revenue, null: false
      t.decimal :expenses, null: false
      t.decimal :contributions, null: false

      t.timestamps
    end

    create_table :open_startup_metrics do |t|
      t.date :occurred_on, null: false
      t.jsonb :data, null: false, default: {}

      t.timestamps
    end
  end
end
