class InvitationsController < ApplicationController

  before_action :logged_in_user, only: [:new]

  def new
    @invitation = Invitation.new
  end

  def check
    if Invitation.valid_token?(params[:invitation_token])
      redirect_to signup_path(invitation_token: params[:invitation_token])
    else
      flash[:error] = t('invitations.not_valid')
      redirect_to invite_path
    end
  end

  def create
    @invitation = current_user.invitations.new(invitation_params)
    if @invitation.save
      UserMailer.send_invitation(@invitation, current_user, check_invitation_url(@invitation)).deliver_now
      flash[:success] = t('invitations.invitation_sent')
      redirect_to invite_path
    else
      render 'new'
    end
  end

  private

  def invitation_params
    params.require(:invitation).permit(:invited_email)
  end
end
