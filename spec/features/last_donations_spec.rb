require 'rails_helper'

RSpec.feature 'Latest donations' do
  background do
    @project = create_project(:name => 'Wikiwadus')
    @user = create_user(name: 'Yorch', password: 'wadusm4n', email: "yorch@example.com")

    other_user = create_user(name: 'Bruce', email: "bruce@example.com")

    create_donation project: @project, quantity: 20, date: Date.today, user: @user, quantity_privacy: true
    create_donation project: @project, quantity: 30, date: Date.today, user: other_user
    create_donation project: @project, quantity: 10, date: Date.today, user: other_user, quantity_privacy: true
  end

  scenario 'I can see the latest donations as an anonymous user' do
    visit donations_page

    expect(page).to have_content 'Yorch donated to Wikiwadus'
    expect(page).to have_content 'Bruce donated to Wikiwadus'
  end

  scenario 'I can see the latest donations as a logged user' do
    login_as "yorch@example.com", "wadusm4n"

    visit donations_page

    expect(page).to have_content 'Yorch donated to Wikiwadus'
    expect(page).to have_content 'Bruce donated to Wikiwadus'
  end
end
