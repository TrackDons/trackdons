class MergeDonationsAndRecurringDonations < ActiveRecord::Migration
  def up
    add_column :donations, :frequency_units, :integer
    add_column :donations, :frequency_period, :string
    add_column :donations, :finished_at, :date

    RecurringDonation.find_each do |recurring_donation|
      d = Donation.new
      d.user = recurring_donation.user
      d.project = recurring_donation.project
      d.quantity_cents = recurring_donation.quantity_cents
      d.currency = recurring_donation.currency
      d.frequency_period = recurring_donation.frequency_period
      d.frequency_units = recurring_donation.frequency_units
      d.date = recurring_donation.date
      d.finished_at = recurring_donation.finished_at
      d.quantity_privacy = recurring_donation.quantity_privacy
      d.save!

      recurring_donation.donations.each(&:destroy)
    end
  end

  def down
  end
end
