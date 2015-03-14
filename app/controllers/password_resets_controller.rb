class PasswordResetsController < ApplicationController
  before_action :load_user, only: [:edit, :update]

  def create
    if user = User.find_by_email(params[:email])
      user.generate_password_reset_token!
      UserMailer.password_reset(user).deliver_now

      flash[:success] = t('.success')
    else
      modal_error('password_resets', t('.invalid_email'))
    end

    redirect_to(:back)
  end

  def edit
    if @user.nil?
      render 'new'
      flash.now[:error] = t('.invalid_token')
    end
  end

  def update
    if @user.update_attributes(user_params)
      log_in @user
      flash[:success] = t('.success')
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

  def load_user
    @user = User.find_by_password_reset_token(params[:id])
  end

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
