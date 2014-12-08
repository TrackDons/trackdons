class PagesController < ApplicationController
  before_filter :set_new_donation, only: :index

  def index
  end
end
