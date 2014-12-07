module DonationsCalculations
  extend ActiveSupport::Concern

  def total_donations_last_month
    sum(donations.last_month)
  end

  def total_donations
    sum(donations)
  end

  private

  def sum(amounts)
    if amounts.any?
      amounts.map(&:quantity).inject(&:+)
    else
      Money.new(0, 'USD')
    end
  end
end
