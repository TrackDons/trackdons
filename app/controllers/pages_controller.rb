class PagesController < ApplicationController

  def root
    if logged_in?
      redirect_to donations_path(locale: session[:locale] || I18n.default_locale)
    else 
      redirect_to root_path(locale: session[:locale] || I18n.default_locale)
    end
  end

  def index
    if logged_in?
      redirect_to donations_path(locale: session[:locale] || I18n.default_locale)
    else 
      session[:locale] = params[:locale]
    end
  end

end
