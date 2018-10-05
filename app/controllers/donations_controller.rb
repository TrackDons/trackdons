class DonationsController < ApplicationController

  before_action :logged_in_user, only: [:edit, :update, :destroy]
  before_action :load_user_donation, only: [:edit, :complete, :update, :destroy]

  def index
    @donations = Donation.includes(:project, :user).sorted
  end

  def show
    @donation = Donation.find(params[:id])
  end

  def complete
  end

  def create
    if logged_in?
      save_donation(donation_params)
    else
      save_donation_to_cookie(donation_params)
      redirect_to signup_path
    end
  end

  def edit
  end

  def update
    @donation.update_attributes donation_params
    redirect_to back_url(@donation)
  end

  def destroy
    @donation.destroy
    flash[:success] = t('.destroy_success')

    redirect_back(fallback_location: root_path)
  end

  private

  def donation_params
    params.require(:donation).permit(:quantity, :currency, :date, :comment, :quantity_privacy, :show_comment, :recurring,
                                     :project_id, project_attributes: [:name, :description, :url, :id, :category_id])
  end

  def save_donation_to_cookie(donation_params)
    cookies[:donation] = donation_params.to_json
  end

  def load_user_donation
    @donation = current_user.donations.find(params[:id])
  end

  def back_url(donation)
    if params[:back_url]
      "#{params[:back_url]}#donation-#{donation.id}"
    else
      donation_path(donation)
    end
  end
end
