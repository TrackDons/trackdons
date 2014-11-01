class Project < ActiveRecord::Base
	
  has_many :donations
  has_many :users, through: :donations

	extend FriendlyId
  friendly_id :name, :use => [:slugged]

  validates :name, presence: true, length: { minimum: 5 }
  validates :description, presence: true, length: { minimum: 25 }
  validates :url, presence: true, length: { minimum: 5 }

end
