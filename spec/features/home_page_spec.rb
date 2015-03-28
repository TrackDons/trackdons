require 'rails_helper'

RSpec.feature 'Home page' do
  background do
    @user = create_user(name: 'Yorch', password: 'wadusm4n', :email => "yorch@example.com")
  end

  scenario 'As an anonymous user I should be able to see the intro' do
    visit home_page

    expect(page).to have_css('.question', text: 'Have you ever donated to an NGO or project?')
    expect(page).to have_content('Track your first donation')
  end

   scenario 'As a logged user I should be able to see the name of the project and a form to donate' do
     login_as "yorch@example.com", "wadusm4n"

     visit home_page

     # User is redirected to last donations page
     expect(page).to have_css('h1', text: 'Last donations')
   end
end
