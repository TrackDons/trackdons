require 'rails_helper'

RSpec.feature 'Recover password' do
  background do
    @user = create_user(name: 'Yorch', password: 'wadusm4n', email: "yorch@example.com")
    # This avoids to have two emails in the inbox for yorch@example.com
    reset_mailer
  end

  scenario 'An user recovers her password' do
    visit home_page

    within(:css, "#new_password_resets") do
      fill_in "Email", with: 'yorch@example.com'
      click_button 'Recover password'
    end

    expect(page).to have_content('We have just sent you an email with a link to recover your password')

    open_email_for 'yorch@example.com'
    click_email_link_matching /password_resets/

    expect(page).to have_content('Enter your new password')

    within(:css, '.simple_form') do
      fill_in 'user_password', with: 'waduswadus'
      fill_in 'user_password_confirmation', with: 'waduswadus'
      click_button 'Save changes'
    end

    expect(page).to have_content('Password updated successfully')
    within(:css, '#container') do
      click_link 'Log out'
    end

    login_as 'yorch@example.com', 'waduswadus'

    expect(page).to have_content('Hello Yorch')
  end
end
