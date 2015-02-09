class PagesController < ApplicationController
  before_action :set_new_donation, only: :index

  def root
    redirect_to root_path(locale: session[:locale] || I18n.default_locale)
  end

  def index
    session[:locale] = params[:locale]
  end

end
