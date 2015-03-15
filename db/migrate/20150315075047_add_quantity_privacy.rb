class AddQuantityPrivacy < ActiveRecord::Migration
  def change
    add_column :recurring_donations, :quantity_privacy, :boolean, default: false
  end
end
