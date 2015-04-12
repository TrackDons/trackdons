class Donation < ActiveRecord::Base

  belongs_to :project, counter_cache: true
  belongs_to :user, counter_cache: true
  belongs_to :recurring_donation

  attr_accessor :recurring

  accepts_nested_attributes_for :project

  monetize :quantity_cents, as: :quantity, with_model_currency: :currency

  scope :visible, -> { where(quantity_privacy: false) }
  scope :quantity_private, -> { where(quantity_privacy: true) }
  scope :sorted, -> { order(date: :desc) }
  scope :last_month, -> { where('date >= ?', 1.month.ago) }
  scope :from_users, ->(users_ids) { where(user_id: users_ids) }
  scope :featured, -> { where("comment is not null") }

  validates :project_id, presence: true
  validates :user_id, presence: true
  validates :date, presence: true
  validates :frequency_units, numericality: true, allow_blank: true
  validates :frequency_period, inclusion: { in: %W{ month months year } }, allow_blank: true

  validate :date_is_not_in_the_future

  before_validation :set_frequency, :set_project, :clear_comment

  def show_comment
    comment.present?
  end

  def show_comment=(value)
    @show_comment = value
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

  def recurring?
    frequency_period.present?
  end

  private

    def clear_comment
      if @show_comment == '0'
        self.comment = nil
      end
    end

    def set_project
      if self.project && self.project.new_record?
        self.project = Project.create_with({
          description: self.project.description,
          url: self.project.url}).find_or_create_by(name: self.project.name)
      end
    end

    def set_frequency
      if self.recurring.present? && self.frequency_period.blank? && self.frequency_units.blank? &&
        self.recurring != 'no'
        case self.recurring
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

    def date_is_not_in_the_future
      if self.date && self.date > Date.today
        errors.add(:date, :invalid)
      end
    end

end
