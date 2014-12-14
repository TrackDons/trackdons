class DonationsController < ApplicationController
  before_filter :set_new_donation, only: :new
  
  def index
    if params.has_key?(:project_id)
      project = Project.friendly.find(params[:project_id])
      @donations = Donation.where(project_id: project.id)
    else
      @donations = Donation.all
    end
  end

  def new
  end

  def show
    @donation = Donation.find(params[:id])
  end

  def create
    unless logged_in?
      save_donation_to_cookie(donation_params)
      redirect_to signup_path
    else
      donation_save(donation_params)
      if cookies[:donation]
        cookies.delete(:donation)
      end
    end
  end

  private

    def donation_params
      params.require(:donation).permit(:quantity, :currency, :date, :comment, :quantity_privacy,
                                       :project_id, project_attributes: [:name, :description, :url, :id])
    end

    def save_donation_to_cookie(donation_params)
      cookies[:donation] = donation_params.to_json
    end

end
