class Donation < ActiveRecord::Base

  belongs_to :project
  belongs_to :user

  default_scope -> { order('created_at DESC') }
  # scope :last_month, where('created_at >= ?', 1.month.ago)

  attr_accessor :project_name
  # acts_as_taggable_on :tags

  validates :quantity_cents, presence: true
  validates :currency, presence: true
  validates :project_id, presence: true
  validates :user_id, presence: true
  validates :date, presence: true

end
