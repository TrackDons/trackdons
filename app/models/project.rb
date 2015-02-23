class Project < ActiveRecord::Base

  has_many :donations
  has_many :users, through: :donations
  belongs_to :category

  extend FriendlyId
  friendly_id :name, :use => [:slugged]

  validates :name, length: { minimum: 3 }, uniqueness: true
  validates :description, length: { minimum: 25 }
  validates :url, length: { minimum: 5 }
  validate :valid_countries

  scope :alpha, -> { order(name: :asc) }
  scope :latest, -> { order(created_at: :desc) }
  scope :popular, -> { order(donations_count: :desc) }
  scope :category, lambda { |category| where(category_id: category.id) }
  scope :country, lambda { |country| where("? = ANY(countries)", country) }

  def self.sorted_by(order)
    case order
      when 'latest'
        order(created_at: :desc)
      when 'alpha'
        order(name: :asc)
      when 'popular'
        order(donations_count: :desc)
    end
  end

  def self.search(query)
    if query.present?
      where(["lower(name) like ?", "%#{query}%"])
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

  private

    def valid_countries
      if self.countries.any?
        if (self.countries - I18nCountrySelect::Countries::COUNTRY_CODES).any?
          errors.add(:countries, I18n.t('activerecord.errors.models.project.attributes.countries.invalid'))
        end
      end
    end

    def clean_twitter_account_value(twitter_account)
      if twitter_account =~ /\Ahttp/
        twitter_account = twitter_account.split('/').last
      elsif twitter_account =~ /\@/
        twitter_account.tr!('@', '')
      end

      twitter_account
    end
end
