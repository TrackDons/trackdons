class InvitationsController < ApplicationController

  before_action :logged_in_user, only: [:new]

  def new
    @invitation = Invitation.new
  end

  def check
    # user is not logged in
    # search for a valid invite with the given token
    @invitation = Invitation.find_valid_token(params[:invitation_token])
    if @invitation.present?
      # allow him to see sign up page
      redirect_to signup_path(params[:invitation_token])
    else
      flash[:error] = t('invitations.not_valid')
      redirect_to invite_path
    end
  end

  def create
    @invitation = current_user.invitations.new(invitation_params)
    if @invitation.save
      UserMailer.send_invitation(@invitation, current_user, invitation_url(@invitation)).deliver
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

  def invitation_url(invitation)
    url_for(controller: 'invitations', action: 'check', invitation_token: invitation.invitation_token, only_path: false)
  end
end
