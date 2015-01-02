class Invitation < ActiveRecord::Base
  belongs_to :user

  before_validation :generate_invitation_token
  # before_save { self.email = email.downcase.strip }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :invited_email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }

  private

    def generate_invitation_token
      self.invitation_token = User.new_token
    end

end
