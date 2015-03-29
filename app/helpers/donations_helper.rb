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

  def in_complete_donation_page?
    controller_name == 'donations' && action_name == 'complete'
  end

  def new_donation?
    @donation.new_record?
  end

  def editing_donation?
    !new_donation?
  end

  def donation_for_form
    if @project && !@project.new_record?
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

  def recurring_options_for_select
    [
      ['No', 'no'],
      [t('.monthly'), 'monthly'],
      [t('.months', n: 2), '2 months'],
      [t('.months', n: 3), '3 months'],
      [t('.months', n: 4), '4 months'],
      [t('.months', n: 6), '6 months'],
      [t('.yearly'), '1 year']
    ]
  end
end
