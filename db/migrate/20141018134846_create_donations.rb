class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
      t.integer :quantity_cents
      t.string :currency
      t.date :date
      t.text :comment
      t.string :tags
      t.boolean :quantity_privacy, default: false
      t.references :project, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
