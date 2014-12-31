class Donation < ActiveRecord::Base

  belongs_to :project
  accepts_nested_attributes_for :project

  belongs_to :user
  before_validation :set_project, :clear_comment

  monetize :quantity_cents, as: :quantity, with_model_currency: :currency

  default_scope -> { order('created_at DESC') }
  scope :last_month, -> { where('date >= ?', 1.month.ago) }
  # acts_as_taggable_on :tags

  validates :project_id, presence: true
  validates :user_id, presence: true
  validates :date, presence: true

  def set_project
    if self.project && self.project.new_record?
      self.project = Project.create_with({
        description: self.project.description,
        url: self.project.url}).find_or_create_by(name: self.project.name)
    end
  end

  def show_comment
    comment.present?
  end

  def show_comment=(value)
    @show_comment = value
  end

  private

  def clear_comment
    if @show_comment == false
      self.comment = nil
    end
  end

end
