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
    @donations = DonationCollection.all(user: @user)
  end

  def create
    redirect_to current_user if logged_in?

    @user = User.new(user_params)

    if session[:external_service_auth_information]
      if user = User.find_by(email: @user.email)
        log_in user
        link_external_service(current_user, session[:external_service_auth_information])

        save_pending_donations || redirect_to(current_user)
        return
      end
    end

    if @user.save
      log_in @user

      if invitation = @user.invitation
        invitation.mark_as_used!(@user)
      end

      link_external_service(current_user, session[:external_service_auth_information])
      save_pending_donations || redirect_to(@user)
    else
      modal_error('signup', t('.invalid_data'))
      redirect_to(:back)
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
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :country, :username, :invitation_token)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

    def load_user
      @user = User.find(params[:id])
    end

    def link_external_service(current_user, external_service_auth_information)
      if external_service_auth_information
        current_external_services = ExternalServiceManager.new(current_user)
        current_external_services.link_to_service(ActiveSupport::HashWithIndifferentAccess.new(external_service_auth_information))
        external_service_auth_information.clear
      end
    end
end
