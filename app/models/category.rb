class Category < ApplicationRecord

  translates :name

  has_many :projects

  extend FriendlyId
  friendly_id :name, use: :slugged

end
