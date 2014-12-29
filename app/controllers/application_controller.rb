class ApplicationController < ActionController::Base

  http_basic_authenticate_with name: "track", password: "wadus", if: -> { Rails.env.production? }

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsManagement

  before_action :set_locale

  helper_method :current_user, :extract_locale_from_subdomain, :logged_in?

  def set_locale
    I18n.locale = extract_locale_from_subdomain || I18n.default_locale
  end

  def extract_locale_from_subdomain
    parsed_locale = request.subdomains.first
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
  end
  helper_method :extract_locale_from_subdomain

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

end
