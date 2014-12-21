class Project < ActiveRecord::Base

  has_many :donations
  has_many :users, through: :donations

  extend FriendlyId
  friendly_id :name, :use => [:slugged]

  validates :name, length: { minimum: 5 }, uniqueness: true
  validates :description, length: { minimum: 25 }
  validates :url, length: { minimum: 5 }

  def self.search(query)
    if query.present?
      where(["name like ?", "%#{query}%"])
    else
      order(name: :asc)
    end
  end

end
