module Paths
  def home_page
    '/'
  end

  def signup_page(invitation)
    "/signup/#{invitation.invitation_token}"
  end

  def donations_page
    "/donations"
  end

  def donation_page(donation)
    "/donations/#{donation.id}"
  end

  def project_page(project)
    "/projects/#{project.slug}"
  end

  def projects_page
    "/projects"
  end

  def user_page(user)
    "/users/#{user.id}"
  end
end
