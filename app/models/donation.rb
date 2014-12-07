class Donation < ActiveRecord::Base

  belongs_to :project
  belongs_to :user

  monetize :quantity_cents, as: :quantity, with_model_currency: :currency

  default_scope -> { order('created_at DESC') }
  scope :last_month, -> { where('date >= ?', 1.month.ago) }

  attr_accessor :project_name
  # acts_as_taggable_on :tags

  #validates :quantity_cents, presence: true
  #validates :currency, presence: true
  validates :project_id, presence: true
  validates :user_id, presence: true
  validates :date, presence: true

end
