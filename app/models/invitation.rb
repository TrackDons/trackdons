class Invitation < ApplicationRecord
  belongs_to :user
  belongs_to :invited_user, class_name: User

  before_validation :generate_invitation_token, :sanitize_email

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :invited_email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX },
                            uniqueness: { case_sensitive: false }
  validates_associated :user

  scope :not_used, ->{ where(used: false) }

  after_create :decrement_user_inviations

  def self.valid_token?(token)
    find_valid_token(token).present?
  end

  def self.find_valid_token(token)
    not_used.find_by(invitation_token: token)
  end

  def to_param
    invitation_token
  end

  def mark_as_used!(invited_user)
    self.invited_user = invited_user
    self.used = true
    save!

    user.increment!(:available_invitations)

    UserMailer.accepted_invitation(self.user, self.invited_user).deliver_now
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
