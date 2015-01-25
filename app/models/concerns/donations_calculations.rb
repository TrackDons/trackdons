module DonationsCalculations
  extend ActiveSupport::Concern

  def total_donations_last_month(user)
    if self == user
      sum(donations.last_month)
    else
      sum(donations.visible.last_month)
    end
  end

  def total_donations(user)
    if self == user
      sum(donations)
    else
      sum(donations.visible)
    end
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
