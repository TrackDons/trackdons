require 'rails_helper'

RSpec.feature 'Latest donations' do
  background do
    Timecop.freeze Time.parse('2015-4-1')

    wikiwadus = create_project(:name => 'Wikiwadus')
    gnome = create_project(:name => 'Gnome')

    user = create_user(name: 'Yorch', password: 'wadusm4n', email: "yorch@example.com")
    other_user = create_user(name: 'Bruce', email: "bruce@example.com")

    create_donation project: wikiwadus, quantity: 20, date: Date.parse('2015-01-01'), user: user, quantity_privacy: true
    create_donation project: wikiwadus, quantity: 30, date: Date.parse('2015-03-01'), user: other_user
    create_donation project: gnome, quantity: 10, date: Date.parse('2014-02-01'), user: other_user, quantity_privacy: true
    create_donation project: gnome, quantity: 20, date: Date.parse('2014-01-01'),
                    user: user, quantity_privacy: true, frequency_units: 1, frequency_period: 'year'
  end

  scenario 'I can see the latest donations as an anonymous user' do
    visit donations_page

    expect(page).to have_css('.donation:nth-child(2)', text: 'Bruce donated to Wikiwadus # Mar 01 2015')
    expect(page).to have_css('.donation:nth-child(3)', text: 'Yorch donated to Wikiwadus # Jan 01 2015')
    expect(page).to have_css('.donation:nth-child(4)', text: 'Bruce donated to Gnome # Feb 01 2014')
    expect(page).to have_css('.donation:nth-child(5)', text: 'Yorch donated to Gnome # Jan 01 2014')
  end

  scenario 'I can see the latest donations as a logged user' do
    login_as "yorch@example.com", "wadusm4n"

    visit donations_page

    donations = page.all(:css, '.donation')
    expect(donations[0].text).to start_with('Bruce donated to Wikiwadus # Mar 01 2015')
    expect(donations[1].text).to start_with('Yorch donated to Wikiwadus # Jan 01 2015')
    expect(donations[2].text).to start_with('Bruce donated to Gnome # Feb 01 2014')
    expect(donations[3].text).to start_with('Yorch donated to Gnome # Jan 01 2014')
  end
end
