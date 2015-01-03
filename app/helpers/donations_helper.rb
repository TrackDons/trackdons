module DonationsHelper

  def temp_donations_exist?
    cookies[:donation].present?
  end

  def in_projects_page?
    controller_name == 'projects' && action_name == 'show'
  end

  def in_users_page?
    controller_name == 'users' && action_name == 'show'
  end

  def in_donations_page?
    controller_name == 'donations' && action_name == 'show'
  end

  def editing_donation?
    !@donation.new_record?
  end

  def new_donation?
    @donation.new_record?
  end

  def donation_for_form
    if @project
      [@project, @project.donations.build]
    else
      if editing_donation?
        @project = @donation.project
        [@project, @donation]
      else
        @donation
      end
    end
  end

  def donation_form_button_text
    if @donation.new_record?
      'TrackDon'
    else
      t('.update_donation')
    end
  end
end
