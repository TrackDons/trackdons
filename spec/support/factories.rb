module Factories
  def create_project(attrs = {})
    attrs[:name]          ||= "Wikiwadus"
    attrs[:description]   ||= "A Wiki to track whatever you can think of"
    attrs[:url]           ||= "http://wikiwad.us"
    attrs[:twitter]       ||= "wikiwadus"
    attrs[:donation_url]  ||= "http://wikiwad.us/donate"
    Project.create!(attrs)
  end

  def create_user(attrs = {})
    attrs[:name]      ||= "John Donor"
    attrs[:username]  ||= attrs[:name].parameterize
    attrs[:email]     ||= "johndonor@example.com"
    attrs[:country]   ||= "ES"
    attrs[:password]              ||= "wadusm4n"
    attrs[:password_confirmation] ||= attrs[:password]
    User.create!(attrs)
  end

  def create_donation(attrs = {})
    attrs[:user]            ||= create_user
    attrs[:project]         ||= create_project
    attrs[:quantity]        ||= 10
    attrs[:currency]        ||= 'EUR'
    attrs[:date]            ||= Date.today - 7.days
    attrs[:quantity_privacy]||= false

    Donation.create!(attrs)
  end

  def create_invitation(attrs = {})
    attrs[:invited_email] ||= "johndonor@example.com"
    Invitation.create!(attrs)
  end

  def create_category(attrs = {})
    attrs[:name_translations] ||= { en: "Animals" }
    Category.create!(attrs)
  end
end
