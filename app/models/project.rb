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

  def total_people_donated
    users.distinct.length
  end

  def total_donations
    donations.length
  end

  def last_month_donations
    donations.where('date >= ?', 1.month.ago).length
  end
end
