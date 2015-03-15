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

  validates :project_id, presence: true
  validates :user_id, presence: true
  validates :date, presence: true

  validate :date_is_not_in_the_future

  before_validation :set_project, :clear_comment

  def show_comment
    comment.present?
  end

  def show_comment=(value)
    @show_comment = value
  end

  def private?
    quantity_privacy?
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

    def date_is_not_in_the_future
      if self.date && self.date > Date.today
        errors.add(:date, :invalid)
      end
    end

end
