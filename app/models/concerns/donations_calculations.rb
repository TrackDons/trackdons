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
      amounts.map(&:quantity).inject(&:+).exchange_to(self.currency)
    else
      Money.new(0, self.currency)
    end
  end
end
