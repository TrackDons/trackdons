class Donation < ActiveRecord::Base

  belongs_to :project
  belongs_to :user
  attr_accessor :project_name, :project_description, :project_url
  before_validation :set_project

  monetize :quantity_cents, as: :quantity, with_model_currency: :currency

  default_scope -> { order('created_at DESC') }
  scope :last_month, -> { where('date >= ?', 1.month.ago) }
  # acts_as_taggable_on :tags

  #validates :quantity_cents, presence: true
  #validates :currency, presence: true
  validates :project_id, presence: true
  validates :user_id, presence: true
  validates :date, presence: true
  
  def set_project
    unless self.project.present?
      self.project = Project.create_with( 
      :description => @project_description,
      :url => @project_url).find_or_create_by(:name => @project_name)
    end
  end

end
