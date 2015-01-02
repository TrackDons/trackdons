class InvitationsController < ApplicationController

  before_action :logged_in_user, only: [:new]

  def new
  end

  def create
    # validations in model? 
    # check if email exists
    # user = User.find_by_email()
    @invitation = Invitation.new(invitation_params)
    if @invitation.save
      # send to invitee
      UserMailer.send_invitation(@invitation).deliver # ToDo update to deliver_later after upgrade

      # decrease counter
      # redirect to invite_path
      flash[:success] = t('invitations.invitation_sent')
      @user
      redirect_to invite_path
    else
      flash[:error] = t('invitations.already_exists')
      redirect_to invite_path
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

    def generate_invitation_token

    end

    def send_invitation

    end

    def decrease_counter

    end


end
