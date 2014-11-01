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
    donation_quantity_with_currency = 'wadus'
  end

  def create
    # ToDo: Check if user is logged in
    @donation = current_user.donations.build(donation_params)
    if @donation.save
      flash[:success] = t(:donation_created)
      project = Project.friendly.find(donation_params[:project_id])
      redirect_to project_donations_path(project.friendly_id) # hacer la vista para una donation
    else
      render 'new'
    end
  end


  # @user.tag_list.add("awesome", "slick")
  
  
  private
    def donation_params
      params.require(:donation).permit(:quantity, :currency, :date, :tag_list, :project_id)
    end

end