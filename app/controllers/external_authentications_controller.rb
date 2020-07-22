class ExternalAuthenticationsController < ApplicationController

  before_action :logged_in_user, only: [:index, :destroy]
  before_action :set_user,  only: [:index, :destroy]
  before_action :set_current_external_services,  only: [:index, :destroy]

  def index
  end

  def create
    auth_information = request.env['omniauth.auth']
    render(text: '', status: :not_found) and return if auth_information.nil?

    if logged_in?
      set_current_external_services
      @current_external_services.link_to_service(auth_information)

      flash[:success] = t('.link_successful')
      # TODO: use user locale
      redirect_to external_authentications_path(I18n.locale)
    else
      if user = ExternalServiceManager.authenticate(User, auth_information)
        if !logged_in?
          log_in(user)
          save_pending_donations
          # TODO: use user locale
          redirect_to user_path(I18n.locale, current_user) and return
        end
      else
        user = ExternalServiceManager.create_instance(User, auth_information)
        if user.new_record?
          user.errors.clear
          @user = user
          session[:external_service_auth_information] = auth_information.slice(:uid, :credentials, :provider, :info)

          render 'complete_signup'
        else
          log_in user

          save_pending_donations || redirect_to(user, success: "Welcome to TrackDons. Hope you track a lot of dons!")
        end
      end
    end
  end

  def failure
  end

  def destroy
    @current_external_services.unlink_from_service(params[:id].to_sym)
    flash[:success] = t('.unlink_successful')

    redirect_to external_authentications_path
  end

  private

  def set_user
    @user = current_user
  end

end
