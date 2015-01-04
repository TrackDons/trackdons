class User < ActiveRecord::Base
  include DonationsCalculations

  has_secure_password

  has_many :donations, dependent: :destroy
  has_many :projects, through: :donations
  has_many :invitations

  attr_accessor :remember_token, :invitation_token

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
	validates :name, presence: true, length: { maximum: 50 }
  validates :password, length: { minimum: 6 }, allow_blank: true
  validates :country, presence: true

  validate :valid_invitation_token, on: :create

  before_validation :set_currency
  before_save { self.email = email.downcase.strip }

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

  private

  def set_currency
    if new_record? && self.country.present?
      self.currency = CurrencyFromCountry.new(self.country).currency
    end
  end

  def valid_invitation_token
    self.invitation_token.present? && Invitation.valid_token?(self.invitation_token)
  end

end
