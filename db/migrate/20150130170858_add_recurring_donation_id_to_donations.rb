class AddRecurringDonationIdToDonations < ActiveRecord::Migration
  def change
    add_column :donations, :recurring_donation_id, :integer

    add_index :donations, :recurring_donation_id
  end
end
