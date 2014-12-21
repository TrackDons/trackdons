require 'rails_helper'

RSpec.feature 'Creating projects' do
  background do
    @user = create_user(name: 'Yorch', password: 'wadusm4n', email: "yorch@example.com")
  end

  scenario 'As a logged user I should be able to create new projects' do
    login_as "yorch@example.com", "wadusm4n"

    visit '/projects'
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
  end
end
