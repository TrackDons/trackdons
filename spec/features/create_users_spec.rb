require 'rails_helper'

RSpec.feature 'Users signup' do
  scenario 'When I have an invitation I can signup' do
    visit signup_page

    fill_in 'Name', with: 'Yorch'
    fill_in 'Email', with: 'yorch@example.com'
    fill_in 'Password', with: 'wadus'
    fill_in 'Password confirmation', with: 'tradus'
    select 'Spain', from: 'Country'
    click_button 'Save'

    expect(page).to have_content('The form contains 2 errors')

    fill_in 'Password', with: 'waduswadus'
    fill_in 'Password confirmation', with: 'waduswadus'
    click_button 'Save'

    expect(page).to have_content('Hello Yorch')
  end
end
