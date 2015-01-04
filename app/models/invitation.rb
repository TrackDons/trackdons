class Invitation < ActiveRecord::Base
  belongs_to :user

  before_validation :generate_invitation_token, :sanitize_email
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :invited_email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates_associated :user

  scope :not_used, ->{ where(used: false) }

  after_create :decrement_user_inviations

  def self.valid_token?(token)
    find_valid_token(token).present?
  end

  def self.find_valid_token(token)
    not_used.find_by(invitation_token: token)
  end

  private

  def generate_invitation_token
    self.invitation_token = User.new_token
  end

  def sanitize_email
    self.invited_email = self.invited_email.downcase.strip
  end

  def decrement_user_inviations
    user.decrement!(:available_invitations) if user
  end
end
