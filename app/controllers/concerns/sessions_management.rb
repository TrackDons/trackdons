module SessionsManagement

  extend ActiveSupport::Concern

  def logged_in?
    !!current_user
  end

  def current_user
    @current_user ||= if (user_id = session[:user_id])
      User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        user
      end
    end
  end

  def current_user?(user)
    logged_in? && user == current_user
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = t('.please_log_in')
      redirect_to login_path and return false
    end
  end

  private

  def log_in(user)
    session[:user_id] = user.id
    params[:session] && params[:session][:remember_me] == '1' ? remember(user) : forget(user)
  end

  def log_out
    forget(current_user)
    reset_session
    @current_user = nil
  end

  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
end
