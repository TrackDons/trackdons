class Project < ActiveRecord::Base

  has_many :donations
  has_many :users, through: :donations
  belongs_to :category

  extend FriendlyId
  friendly_id :name, :use => [:slugged]

  acts_as_followable

  validates :name, length: { minimum: 3 }, uniqueness: true
  validates :description, length: { minimum: 25 }
  validates :url, length: { minimum: 5 }

  scope :alpha, -> { order(name: :asc) }
  scope :latest, -> { order(id: :desc) }
  scope :popular, -> { order(donations_count: :desc) }
  scope :category, lambda { |category| where(category_id: category.id) }
  scope :country, lambda { |country| where("? = ANY(countries)", country) }

  def self.search(query)
    if query.present?
      where(["lower(name) like ?", "%#{query}%".downcase])
    else
      self
    end
  end

  def self.used_countries
    pluck(:countries).flatten.uniq.map do |country|
      [I18n.t(country, :scope => :countries), country]
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

  def geographical_scope
    if countries.any?
      countries.map{|c| I18n.t("countries.#{c}") }
    else
      :global
    end
  end

  def related_projects
    @related_projects ||= begin
      project_source = if category
        category.projects
      else
        self.class
      end

      project_source.where.not(id: self.id).first(3)
    end
  end

  private

    def clean_twitter_account_value(twitter_account)
      if twitter_account =~ /\Ahttp/
        twitter_account = twitter_account.split('/').last
      elsif twitter_account =~ /\@/
        twitter_account.tr!('@', '')
      end

      twitter_account
    end
end
