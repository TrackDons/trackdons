class UsersController < ApplicationController

  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :profile_owner,  only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  before_action :load_user,      only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
    @projects_following = @user.following_by_type('Project')
  end

  def new
    redirect_to current_user if logged_in?

    @user = User.new
  end

  def create
    redirect_to current_user if logged_in?

    @user = User.new(user_params)
    if @user.save
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
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :country, :username)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

    def load_user
      @user = User.find(params[:id])
    end
end
