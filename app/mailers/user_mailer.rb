class UserMailer < ApplicationMailer

  # def welcome(user)
  #   @user = user
  #   @url  = 'http://selladay.ajogalvan.com'
  #   mail(to: @user.email, subject: t('users.your_sell_a_day_adventure_starts'))
  # end

  # def password_reset(user)
  #   @user = user
  #   mail to: user.email, subject: t("users.password_reset")
  # end

  def send_invitation(invitation)
    @invitation = invitation
    mail to: invitation.invited_email, subject: t("invitations.invitation_send_subject", :friend => invitation.user)
  end

end
