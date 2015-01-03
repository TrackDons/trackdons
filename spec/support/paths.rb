module Paths
  def donation_page(donation)
    "/donations/#{donation.id}"
  end

  def project_page(project)
    "/projects/#{project.slug}"
  end

  def user_page(user)
    "/users/#{user.id}"
  end
end
