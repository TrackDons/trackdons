class Category < ActiveRecord::Base
  has_many :projects
  extend FriendlyId
  friendly_id :name, use: :slugged
end
