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
end
