module DonationsHelper

  def donation_save(donation_params)
    @donation = current_user.donations.build(donation_params)
    if @donation.save
      flash[:success] = t(:donation_created)
      project = Project.friendly.find(donation_params[:project_id])
      redirect_to project_donations_path(project.friendly_id) # TODO create the donation view with share buttons etc
      return
    else
      render 'new'
    end
  end

  def cookie_donation
    cookie_donation = JSON.parse(cookies[:donation]).with_indifferent_access
  end 

  def temp_donations_exist
    cookies[:donation] # check if the cookie donation is set 
  end 
  
end
