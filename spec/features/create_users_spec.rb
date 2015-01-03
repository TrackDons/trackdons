require 'rails_helper'

RSpec.feature 'Users signup' do
  scenario 'As a logged in user, I should be able to create a new project on the fly' do
    visit home_page

    within(:css, '#container') do
      click_link 'Track your first donation'
    end

    fill_in 'Name', with: 'Yorch'
    fill_in 'Email', with: 'yorch@example.com'
    fill_in 'Password', with: 'wadus'
    fill_in 'Confirmation', with: 'tradus'
    select 'Spain', from: 'Country'
    click_button 'Create my account'

    expect(page).to have_content('The form contains 2 errors')

    fill_in 'Password', with: 'waduswadus'
    fill_in 'Confirmation', with: 'waduswadus'
    click_button 'Create my account'

    expect(page).to have_content('Hello Yorch')
  end
end
