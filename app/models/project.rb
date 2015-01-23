class Project < ActiveRecord::Base

  has_many :donations
  has_many :users, through: :donations
  belongs_to :category

  extend FriendlyId
  friendly_id :name, :use => [:slugged]

  validates :name, length: { minimum: 3 }, uniqueness: true
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
    users.distinct.count
  end

  def total_donations
    donations.size
  end

  def last_month_donations
    donations.where('date >= ?', 1.month.ago).count
  end

  def twitter=(value)
    super(clean_twitter_account_value(value))
  end

  private

  def clean_twitter_account_value(twitter_account)
    if twitter_account =~ /\Ahttp/
      twitter_account = twitter_account.split('/').last
    elsif twitter_account =~ /\@/
      twitter_account = twitter_account.tr('@', '')
    end

    twitter_account
  end
  
end
