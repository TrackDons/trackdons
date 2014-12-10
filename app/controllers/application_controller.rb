class ApplicationController < ActionController::Base

  http_basic_authenticate_with name: "track", password: "wadus", if: -> { Rails.env.production? }

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  include ProjectsHelper
  include DonationsHelper

  before_action :set_locale

  helper_method :extract_locale_from_subdomain
 
  def set_locale
    I18n.locale = extract_locale_from_subdomain || I18n.default_locale
    # I18n.locale = params[:locale] || I18n.default_locale
  end

  def extract_locale_from_subdomain
    parsed_locale = request.subdomains.first
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
  end

  protected

  def set_new_donation
    new_donation_currency = logged_in? ? current_user.currency : 'EUR'
    @donation = Donation.new currency: new_donation_currency
  end

end
