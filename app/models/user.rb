class User < ApplicationRecord
  include DonationsCalculations
  include ChartData

  acts_as_followable
  acts_as_follower

  has_secure_password validations: false

  has_many :donations, dependent: :destroy
  has_many :recurring_donations, dependent: :destroy
  has_many :projects, through: :donations
  has_many :invitations

  attr_accessor :remember_token, :external_service, :invitation_token

  hstore_accessor :credentials, twitter_id:     :string,
                                twitter_login:  :string,
                                twitter_token:  :string,
                                twitter_secret: :string,
                                facebook_id:    :string,
                                facebook_token: :string

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
	validates :name, presence: true, length: { maximum: 50 }
  validates :password, length: { minimum: 6 }, confirmation: true, if: Proc.new{|u| u.external_service.blank? }, allow_blank: true
  validates :country, presence: true

  validate :valid_invitation_token, on: :create

  before_validation :set_currency
  before_save { self.email = email.downcase.strip }

  # def self.name
  #   if current_user?(self)
  #     self.name = 'You'
  #   end
  # end

  # Returns the hash digest of the given string.
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def has_private_donations?
    donations.quantity_private.any?
  end

  def generate_password_reset_token!
    generate_token(:password_reset_token)
    save!
  end

  def invitation
    self.invitation_token.present? && Invitation.find_valid_token(self.invitation_token)
  end

  private

  def set_currency
    if new_record? && self.country.present?
      self.currency = CurrencyFromCountry.new(self.country).currency
    end
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while self.class.exists?(column => self[column])
  end

  def valid_invitation_token
    if self.invitation_token.present?
      unless Invitation.valid_token?(self.invitation_token)
        self.invitation_token = nil
      end
    end
  end

end
