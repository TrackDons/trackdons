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
    attrs[:username]  ||= "johndonor"
    attrs[:email]     ||= "johndonor@example.com"
    attrs[:country]   ||= "ES"
    attrs[:password]              ||= "wadusm4n"
    attrs[:password_confirmation] ||= attrs[:password]
    User.create!(attrs)
  end
end