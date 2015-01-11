class SessionsController < ApplicationController
  before_action :logged_in_user, only: :destroy

  def new
    #redirect_to root_path if logged_in?
    redirect_to '/auth/twitter'
  end

  def create
    if auth_hash
      @user = User.find_or_create_from_auth_hash(auth_hash)
      # self.current_user = @user
      log_in user
      save_pending_donations || redirect_to(user)
    else
      user = User.find_by(email: params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
        log_in user
        save_pending_donations || redirect_to(user)
      else
        flash.now[:danger] = 'Invalid email/password combination'
        render 'new'
      end
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end

  protected

    def auth_hash
      request.env['omniauth.auth']
    end

end
