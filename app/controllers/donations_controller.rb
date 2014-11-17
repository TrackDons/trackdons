class DonationsController < ApplicationController
  
  def index
    if params.has_key?(:project_id)
      project = Project.friendly.find(params[:project_id])
      @donations = Donation.where(project_id: project.id)
    else
      @donations = Donation.all
    end
  end

  def new
    @donation = Donation.new
  end

  def show
    @donation = Donation.find(params[:id])
  end

  def create
    unless logged_in?
      save_donation_to_cookie(donation_params)
      cookie_donation
      redirect_to root_url
    else
      donation_save(donation_params)
      if cookies[:donation]
        cookies.delete(:donation)
      end
    end
  end

  private

    def donation_params
      params.require(:donation).permit(:quantity_cents, :currency, :date, :project_id, :comment, :quantity_privacy)
    end

    def save_donation_to_cookie(donation_params)
      cookies[:donation] = { 
        :quantity_cents => donation_params[:quantity_cents],
        :currency => donation_params[:currency],
        :date => donation_params[:date],
        #:tag_list => donation_params[:tag_list],
        :project_id => donation_params[:project_id],
        :comment => donation_params[:comment],
        :quantity_privacy => donation_params[:quantity_privacy],
        :user_id => donation_params[:user_id]
      }.to_json
    end

end