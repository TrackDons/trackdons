require 'rails_helper'

RSpec.feature 'Create recurring donations' do
  background do
    Timecop.freeze Time.parse('2014-10-30')

    @project = create_project(name: 'Wikiwadus')
    @user = create_user(name: 'Yorch', password: 'wadusm4n', email: "yorch@example.com")
  end

  scenario 'I see a success page and message' do
    login_as "yorch@example.com", "wadusm4n"

    visit projects_page

    click_link('Wikiwadus')

    within(:css, '#modal-track') do
      fill_in 'donation_date', :with => "2014-09-10"
      fill_in 'donation_quantity', :with => "200.99"
      select '$', from: 'donation_currency'
      select '3 months', from: 'donation_recurring'
      click_button 'TrackDon'
    end

    expect(page).to have_content 'Great! Just one thing before you are done:'
    expect(page).to have_content 'Yorch donated to Wikiwadus'

    # TODO: once we redirect to a nice page that shows recurring donation information
    #       we'll be able to get rid of this check
    donation = Donation.last
    expect(donation).to be_recurring
  end
end
