class SessionsController < ApplicationController
  before_action :logged_in_user, only: :destroy

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      save_pending_donations || redirect_to(user)
      return
    else
      modal_error('login', t('.invalid_data'))
      redirect_to(:back)
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end
end
