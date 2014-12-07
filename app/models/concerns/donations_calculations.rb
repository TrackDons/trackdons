module DonationsCalculations
  extend ActiveSupport::Concern

  def total_donations_last_month
    donations.last_month.map(&:quantity).inject(&:+) || 0
  end

  def total_donations
    donations.map(&:quantity).inject(&:+) || 0
  end
end
