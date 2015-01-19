class ApplicationController < ActionController::Base

  http_basic_authenticate_with name: "track", password: "wadus", if: -> { Rails.env.production? }

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsManagement
  before_action :set_locale
  helper_method :current_user, :extract_locale_from_subdomain, :logged_in?, :current_user?

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
    #I18n.locale = extract_locale_from_accept_language_header
  end

  def default_url_options(options={})
    # logger.debug "default_url_options is passed options: #{options.inspect}\n"
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

    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

end
