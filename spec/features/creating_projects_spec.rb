require 'rails_helper'

RSpec.feature 'Creating projects' do
  background do
    @user = create_user(name: 'Yorch', password: 'wadusm4n', email: "yorch@example.com")
  end

  scenario 'As a logged user I should be able to create new projects' do
    login_as "yorch@example.com", "wadusm4n"

    visit projects_page
    click_link '+'

    fill_in 'Project', with: 'Rubular'
    fill_in 'Description', with: 'Rubular is a regular expression compilar in real time'
    fill_in 'URL', with: 'http://rubular.com'
    fill_in 'Donation URL', with: 'http://rubular.com/donate'
    fill_in 'Twitter', with: 'http://twitter.com/rubular'
    click_button 'Create'

    expect(page).to have_content('Project created')
    expect(page).to have_content('Rubular')
    expect(page).to have_content('rubular.com')
    expect(page).to have_css('a', text: '@rubular')

    fill_in 'donation_date', :with => "2014-10-10"
    fill_in 'donation_quantity', :with => "200"
    click_button 'TrackDon'

    expect(page).to have_content 'Great, your donation is tracked. This is just the beginning.'
    expect(page).to have_content '200€ to Rubular by Yorch'
  end
end
