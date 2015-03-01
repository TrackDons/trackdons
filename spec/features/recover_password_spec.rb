require 'rails_helper'

RSpec.feature 'Recover password' do
  background do
    @user = create_user(name: 'Yorch', password: 'wadusm4n', email: "yorch@example.com")
    # This avoids to have two emails in the inbox for yorch@example.com
    reset_mailer
  end

  scenario 'An user recovers her password' do
    visit login_page

    click_link 'Forgot password?'

    expect(page).to have_content('Enter your email to recover your password')
    fill_in "Email", with: 'bademail.com'
    click_button 'Continue'

    expect(page).to have_content('Invalid email address')

    fill_in "Email", with: 'yorch@example.com'
    click_button 'Continue'
    expect(page).to have_content('We have just sent you an email with a link to recover your password')

    open_email_for 'yorch@example.com'
    click_email_link_matching /password_resets/

    expect(page).to have_content('Enter your new password')

    fill_in 'Password', with: 'waduswadus'
    fill_in 'Password confirmation', with: 'waduswadus'
    click_button 'Save changes'

    expect(page).to have_content('Password updated successfully')
    within(:css, '#container') do
      click_link 'Log out'
    end

    login_as 'yorch@example.com', 'waduswadus'

    expect(page).to have_content('Hello Yorch')
  end
end
