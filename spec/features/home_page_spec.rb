require 'rails_helper'

RSpec.feature 'Home page' do
  background do
    @user = create_user(name: 'Yorch', password: 'wadusm4n', :email => "yorch@example.com")
  end

  scenario 'As an anonymous user I should be able to see the name of the project and a form to donate' do
    visit home_page

    expect(page).to have_css('h1', text: 'TrackDons')
    expect(page).to have_content('Login')
    expect(page).to_not have_css('#donation_project_attributes_name')
  end

  scenario 'As a logged user I should be able to see the name of the project and a form to donate' do
    login_as "yorch@example.com", "wadusm4n"

    visit home_page

    expect(page).to have_content('Hello Yorch')
    expect(page).to have_css('h1', text: 'TrackDons')
    expect(page).to have_css('#donation_project_attributes_name')
  end

end
