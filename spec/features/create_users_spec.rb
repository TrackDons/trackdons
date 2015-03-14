require 'rails_helper'

RSpec.feature 'Users signup' do
  scenario 'When I have an invitation I can signup' do
    visit home_page

    within(:css, '#new_user') do
      fill_in 'Name', with: 'Yorch'
      fill_in 'Email', with: 'yorch@example.com'
      fill_in 'user_password', with: 'waduswadus'
      fill_in 'user_password_confirmation', with: 'waduswadus'
      select 'Spain', from: 'Country'
      click_button 'Create account'
    end

    expect(page).to have_content('Hello Yorch')
  end
end
