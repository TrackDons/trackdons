class RecurringDonation < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  has_many :donations

  validates :user_id, presence: true
  validates :project_id, presence: true
  validates :started_at, presence: true
  validates :currency, presence: true
  validates :quantity_cents, presence: true
  validates :frequency_units, presence: true, numericality: true
  validates :frequency_period, presence: true, inclusion: { in: %W{ day days month months year years week weeks } }

  monetize :quantity_cents, as: :quantity, with_model_currency: :currency

  def self.create_today_donations
    today = Date.today

    find_each do |recurring_donation|
      if recurring_donation.next_donation_date == today and recurring_donation.donations.where(date: today).empty?
        recurring_donation.create_donation!(today)
      end
    end
  end

  def create_pending_donations
    offset = 0
    date   = started_at
    end_date = finished_at || Date.today

    while date < end_date
      create_donation!(date)
      date = donation_date_in_offset(offset += 1)
    end
  end

  def next_donation_date
    return if finished_at.present?

    offset = 0
    date   = started_at
    while date < Date.today
      date = donation_date_in_offset(offset += 1)
    end

    date
  end

  def create_donation!(date)
    self.donations.new.tap do |d|
      d.project = project
      d.user = user
      d.currency = currency
      d.quantity_cents = quantity_cents
      d.date = date
      d.save!
    end
  end

  private

  def donation_date_in_offset(offset)
    started_at + (frequency_units * offset).send(frequency_period.to_sym)
  end

end
