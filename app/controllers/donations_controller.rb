class DonationsController < ApplicationController
  before_filter :set_new_donation, only: :new
  before_action :logged_in_user, only: :destroy

  def index
    @donations = Donation
    if params.has_key?(:project_id)
      project = Project.friendly.find(params[:project_id])
      @donations = @donations.where(project_id: project.id)
    end
  end

  def new
  end

  def show
    @donation = Donation.find(params[:id])
  end

  def create
    if logged_in?
      save_donation(donation_params)
    else
      save_donation_to_cookie(donation_params)
      redirect_to signup_path
    end
  end

  def destroy
    donation = current_user.donations.find(params[:id])
    donation.destroy
    flash[:success] = t('.destroy_success')

    redirect_to :back
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
