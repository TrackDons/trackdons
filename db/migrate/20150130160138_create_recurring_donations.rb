class CreateRecurringDonations < ActiveRecord::Migration
  def change
    create_table :recurring_donations do |t|
      t.integer :user_id, null: false
      t.integer :project_id, null: false
      t.integer :quantity_cents, null: false
      t.string  :currency, null: false
      t.integer :frequency_units, null: false
      t.string  :frequency_period, null: false
      t.date    :started_at, null: false
      t.date    :finished_at

      t.timestamps null: false
    end
  end
end
