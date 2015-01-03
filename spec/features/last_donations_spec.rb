require 'rails_helper'

RSpec.feature 'Latest donations' do
  background do
    @project = create_project(:name => 'Wikiwadus')
    @user = create_user(name: 'Yorch', password: 'wadusm4n', email: "yorch@example.com")

    other_user = create_user(name: 'Bruce', email: "bruce@example.com")

    create_donation project: @project, quantity: 20, date: Date.today, user: @user
    create_donation project: @project, quantity: 30, date: Date.today, user: other_user
  end

  scenario 'I can see the latest donations as an anonymous user' do
    visit donations_page

    expect(page).to have_content '20€ to Wikiwadus by Yorch'
    expect(page).to have_content '30€ to Wikiwadus by Bruce'
  end

  scenario 'I can see the latest donations as a logged user' do
    login_as "yorch@example.com", "wadusm4n"

    visit donations_page

    expect(page).to have_content '20€ to Wikiwadus by Yorch'
    expect(page).to have_content '30€ to Wikiwadus by Bruce'
  end
end
