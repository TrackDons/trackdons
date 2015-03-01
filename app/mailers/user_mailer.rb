class UserMailer < ApplicationMailer

  def password_reset(user)
    @user = user
    @url = edit_password_reset_url(I18n.locale, @user.password_reset_token)
    mail to: user.email, subject: t("password_resets.password_reset_subject")
  end

  def send_invitation(invitation, current_user, url)
    @invitation = invitation
    @name = current_user.name
    @url = url
    mail to: invitation.invited_email, subject: t("invitations.invitation_send_subject", friend: @name)
  end

  def accepted_invitation(inviter, invited_user)
    @name = invited_user.name
    @friend_page = user_url(I18n.locale, invited_user)
    mail to: inviter.email, subject: t("invitations.invitation_accepted_subject", friend: @name)
  end
end
