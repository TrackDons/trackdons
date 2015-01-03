class Invitation < ActiveRecord::Base
  #include ApplicationController::SessionsManagement

  belongs_to :user

  before_validation :generate_invitation_token, :default_values
  before_validation { self.invited_email = invited_email.downcase.strip }
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :invited_email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  # validates :user_id, presence: true
  
  private

    def generate_invitation_token
      self.invitation_token = User.new_token
    end

    def default_values
      self.used = 'false'
    end

end
