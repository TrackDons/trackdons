require 'rails_helper'

RSpec.feature 'Inviting users' do
  background do
    @user = create_user(name: 'Yorch', password: 'wadusm4n', email: "yorch@example.com")
  end

  scenario 'As a logged user I am able to invite some friends' do
    login_as "yorch@example.com", "wadusm4n"

    visit home_page

    within(:css, '#container') do
      click_link 'Invite a friend'
    end

    expect(page).to have_content('You have 5 invites available')

    fill_in "Your friend's email", with: 'bademail.com'
    click_button 'Invite'

    expect(page).to have_content('You have 5 invites available')
 
    fill_in "Your friend's email", with: 'myfriend@example.com'
    click_button 'Invite'

    expect(page).to have_content('You have 4 invites available')

    within(:css, '#container') do
      click_link 'Log out'
    end

    open_email_for 'myfriend@example.com'
    click_email_link_matching /invite/

    expect(page).to have_content('With this invitation you can sign up for TrackDons')

    fill_in 'Name', with: 'Peter'
    fill_in 'Password', with: 'waduswadus'
    fill_in 'Confirmation', with: 'waduswadus'
    select 'Spain', from: 'Country'
    click_button 'Create my account'

    expect(page).to have_content('Hello Peter')

    open_email_for 'yorch@example.com'
    email = current_email
    expect(email).to have_body_text(/Your friend Yorch has just accepted your invitation to join TrackDons.org/)

    @user.reload
    expect(@user.available_invitations).to be(5)
  end
end
