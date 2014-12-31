class DonationsController < ApplicationController
  before_filter :set_new_donation, only: :new
  before_action :logged_in_user, only: :destroy
  before_action :load_donation, only: [:edit, :update, :destroy]

  def index
    @donations = Donation
    if params.has_key?(:project_id)
      project = Project.friendly.find(params[:project_id])
      @donations = @donations.where(project_id: project.id)
    end
  end

  # TODO: can be removed?
  def new
  end

  def show
    @donation = Donation.find(params[:id])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    @donation.update_attributes donation_params
    respond_to do |format|
      format.js { render 'show' }
    end
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
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @donation.destroy
    flash[:success] = t('.destroy_success')

    redirect_to :back
  end

  private

  def donation_params
    params.require(:donation).permit(:quantity, :currency, :date, :comment, :quantity_privacy, :show_comment,
                                     :project_id, project_attributes: [:name, :description, :url, :id])
  end

  def save_donation_to_cookie(donation_params)
    cookies[:donation] = donation_params.to_json
  end

  def load_donation
    @donation = current_user.donations.find(params[:id])
  end

end
