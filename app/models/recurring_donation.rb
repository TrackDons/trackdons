class RecurringDonation < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  has_many :donations

  accepts_nested_attributes_for :project
  attr_accessor :recurring

  validates :user_id, presence: true
  validates :project_id, presence: true
  validates :date, presence: true
  validates :currency, presence: true
  validates :quantity_cents, presence: true
  validates :frequency_units, presence: true, numericality: true
  validates :frequency_period, presence: true, inclusion: { in: %W{ day days month months year years week weeks } }
  validate :date_is_not_in_the_future

  before_validation :set_frequency, :set_project
  after_create { create_pending_donations }

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
    current_date = date
    end_date = finished_at || Date.today

    while current_date < end_date
      create_donation!(current_date)
      current_date = donation_date_in_offset(offset += 1)
    end
  end

  def update_donations
    donations.each do |donation|
      donation.update_attributes(self.attributes.slice(:quantity, :currency, :date, :quantity_privacy)
    end
  end

  def next_donation_date
    return if finished_at.present?

    offset = 0
    current_date = date
    while(current_date < Date.today)
      current_date = donation_date_in_offset(offset += 1)
    end

    current_date
  end

  def create_donation!(in_date)
    self.donations.new.tap do |d|
      d.project = self.project
      d.user = self.user
      d.currency = self.currency
      d.quantity_cents = self.quantity_cents
      d.date = in_date
      d.quantity_privacy = self.quantity_privacy
      d.save!
    end
  end

  def private?
    quantity_privacy?
  end

  def recurring
    if new_record?
      @recurring
    else
      "#{frequency_units} #{frequency_period}"
    end
  end

  private

  def donation_date_in_offset(offset)
    date + (frequency_units * offset).send(frequency_period.to_sym)
  end

  def set_frequency
    if self.recurring.present? && self.frequency_period.blank? && self.frequency_units.blank?
      case self.recurring
      when 'daily'
        self.frequency_period = 'day'
        self.frequency_units = 1
      when 'weekly'
        self.frequency_period = 'week'
        self.frequency_units = 1
      when 'monthly'
        self.frequency_period = 'month'
        self.frequency_units = 1
      when 'yearly'
        self.frequency_period = 'year'
        self.frequency_units = 1
      else
        self.frequency_units, self.frequency_period = self.recurring.split(' ')
      end
    end
  end

  def set_project
    if self.project && self.project.new_record?
      self.project = Project.create_with({
        description: self.project.description,
        url: self.project.url}).find_or_create_by(name: self.project.name)
    end
  end

  def date_is_not_in_the_future
    if self.date && self.date > Date.today
      errors.add(:date, :invalid)
    end
  end

end
