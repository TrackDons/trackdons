class InvitationsController < ApplicationController

  before_action :logged_in_user, only: [:new]

  def new
    @invitation = Invitation.new
  end

  def check
    # user is not logged in
    # search for a valid invite with the given token
    @invitation = Invitation.find_by_invitation_token(params[:invitation_token])
    if @invitation.present?
      # allow him to see sign up page
      redirect_to signup_path(params[:invitation_token])
    else
      flash[:error] = t('invitations.not_valid')
      redirect_to invite_path
    end
  end

  def create
    @invitation = Invitation.new
    @invitation = current_user.invitations.build(invitation_params)
    if @invitation.save
      url = invitation_url(@invitation)
      UserMailer.send_invitation(@invitation, current_user, url).deliver # ToDo update to deliver_later after Rails upgrade
      current_user.decrement!(:available_invitations)
      flash[:success] = t('invitations.invitation_sent')
      redirect_to invite_path
    else
      #flash[:error] = t('invitations.already_exists')
      #redirect_to invite_path
      render 'new'
    end
  end

  private

    def invitation_params
      # t.string   "invitation_token"
      # t.string   "invited_email"
      # t.boolean  "used"
      # t.integer  "user_id"
      # t.datetime "created_at"
      # t.datetime "updated_at"
      params.require(:invitation).permit(:invited_email)
    end

    def decrease_counter

    end

    def invitation_url(invitation)
      url_for(controller: 'invitations', 
        action: 'check',
        invitation_token: invitation.invitation_token,
        host: 'trackdons.org') #ToDo I have some vars in app_config.yml but I don't manage to get them read by the app
    end

end
