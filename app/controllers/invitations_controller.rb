class InvitationsController < ApplicationController

  before_action :logged_in_user, only: [:new]

  def new
  end

  def create
    # validations in model? 
    # check if email exists
    # user = User.find_by_email()
    @user = User.where("email = ?", invite_params[:email]).first

    if @user.present?
      flash[:error] = t('invitations.already_exists')
      redirect_to invite_path
    else
      # generate token
      # send to invitee
      # decrease counter
      # redirect to invite_path
      flash[:success] = t('invitations.invitation_sent')
      @user
      redirect_to invite_path
    end
  end

  private

    def invite_params
      params.require(:invite).permit(:name, :email)
    end

    def generate_invitation_token

    end

    def send_invitation

    end

    def decrease_counter

    end


end
