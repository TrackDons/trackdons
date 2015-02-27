class ExternalAuthenticationsController < ApplicationController

  before_action :logged_in_user, only: [:index, :destroy]
  before_action :set_user,  only: [:index, :destroy]
  before_action :set_current_external_services,  only: [:index, :destroy]

  def index
  end

  def create
    auth_information = request.env['omniauth.auth']
    render(text: '', status: :not_found) and return if auth_information.nil?

    if auth_information[:provider] == 'twitter'
      if logged_in?
        set_current_external_services
        @current_external_services.link_to_service(:twitter, auth_information)

        flash[:success] = t('.link_successful')
        # TODO: use user locale
        redirect_to external_authentications_path(I18n.locale)
      else
        # Twitter user exists in Trackdons
        if user = User.with_twitter_login(auth_information[:info][:nickname]).first
          if !logged_in?
            log_in(user)
            save_pending_donations
            # TODO: use user locale
            redirect_to user_path(I18n.locale, current_user) and return
          end
        else
          # TODO: signup
          render text: 'TO DO'
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

  def set_current_external_services
    @current_external_services = ExternalServiceManager.new(current_user)
  end

end
