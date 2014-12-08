module DonationsHelper

  def donation_save(donation_params)
    @donation = current_user.donations.build(donation_params)
    if @donation.save
      redirect_to donation_path(@donation, :share_links => true)
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

  def in_projects_page?
    controller_name == 'projects' && action_name == 'show'
  end
end
