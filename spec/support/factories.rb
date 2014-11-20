module Factories
  
  def create_project(attrs = {})
    #<Project id: 1, name: "Wikipedia", description: "This is the description of the wikipedia. This is ...", url: "http://www.wikipedia.com", twitter: "wikipedia", donation_url: "https://donate.wikimedia.org/wiki/Special:Fundrais...", created_at: "2014-11-19 11:06:05", updated_at: "2014-11-19 11:06:05", slug: "wikipedia">
    attrs[:name] ||= "Wikiwadus"
    attrs[:description] ||= "A Wiki to track whatever you can think of"
    attrs[:url] ||= "http://wikiwad.us"
    attrs[:twitter] ||= "wikiwadus"
    attrs[:donation_url] ||= "http://wikiwad.us/donate"
    Project.create!(attrs)
  end
  
end