class UsersController < ApplicationController

  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  before_action :load_user,      only: [:show, :edit, :update, :destroy]

  before_action :validates_invitation_token, only: :new # we only allow signups if you have an invitation token

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new email: @invitation.invited_email
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.invitation.try(:mark_as_used!)
      log_in @user
      save_pending_donations || redirect_to(@user, success: "Welcome to TrackDons. Hope you track a lot of dons!")
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated" 
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "User deleted"
    redirect_to users_path
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :country, :invitation_token)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless @user == current_user
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

    def load_user
      @user = User.find(params[:id])
    end

    def validates_invitation_token
      if logged_in?
        flash[:error] = t('users.you_already_have_an_account')
        redirect_to root_path
      else
        if @invitation = Invitation.find_valid_token(params[:invitation_token])
          flash.now[:notice] = t('invitations.welcome_message')
        else
          flash[:error] = t('invitations.not_valid')
          redirect_to root_path
        end
      end
    end
end
