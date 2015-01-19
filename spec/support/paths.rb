module Paths
  def home_page
    locale_preffix + '/'
  end

  def signup_page(invitation)
    locale_preffix + "/signup/#{invitation.invitation_token}"
  end

  def donations_page
    locale_preffix + "/donations"
  end

  def donation_page(donation)
    locale_preffix + "/donations/#{donation.id}"
  end

  def project_page(project)
    locale_preffix + "/projects/#{project.slug}"
  end

  def projects_page
    locale_preffix + "/projects"
  end

  def user_page(user)
    locale_preffix + "/users/#{user.id}"
  end

  def login_page
    locale_preffix + "/login"
  end

  private

  def locale_preffix
    "/en"
  end
end
