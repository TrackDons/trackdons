class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsManagement
  before_action :set_locale
  helper_method :current_user, :logged_in?, :current_user?

  rescue_from OAuth::Unauthorized, with: :external_service_unauthorized

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options={})
    { locale: I18n.locale }
  end

  protected

    def set_new_donation
      new_donation_currency = logged_in? ? current_user.currency : 'EUR'
      @donation = Donation.new currency: new_donation_currency,
                               project: (@project.nil? ? Project.new : @project)
    end

    def save_donation(donation_params)
      @donation = current_user.donations.build(donation_params)
      if donation_params[:project_id] and project = Project.find_by(id: donation_params[:project_id])
        @donation.project = project
      end

      if @donation.save
        cookies.delete(:donation) if cookies[:donation]
        redirect_to donation_path(@donation, :share_links => true)
      else
        render 'new'
      end
    end

    def cookie_donation
      JSON.parse(cookies[:donation]).with_indifferent_access
    end
    helper_method :cookie_donation

    def save_pending_donations
      if cookies[:donation]
        save_donation(cookie_donation)
        flash[:success] = "Hey, donation tracked, and you have your profile ready to keep tracking donations! Now this is a great day."
      end
    end

    def profile_owner
      @user = params[:id] ? User.find(params[:id]) : current_user

      redirect_to(root_path) unless @user == current_user
    end

    def external_service_unauthorized
      flash[:error] = t('.unauthorized')
      redirect_to root_path
    end

    def modal_error(flash_type, message)
      flash[:modal_error] = flash_type
      flash["modal_#{flash_type}_error".to_sym] = message
    end

end
