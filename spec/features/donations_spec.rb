require 'rails_helper'

RSpec.feature 'Donations' do
  background do
    @project = create_project(:name => 'Wikiwadus')
    @user = create_user(name: 'Yorch', password: 'wadusm4n', email: "yorch@example.com")
  end

  scenario 'I see the total amount of donations' do
    create_donation project: @project, quantity: 20.12, date: Date.today, user: @user
    create_donation project: @project, quantity: 10.50, date: 32.days.ago, user: @user

    login_as "yorch@example.com", "wadusm4n"

    click_link 'Yorch'

    expect(page).to have_content('20.12€ donated in the last month')
    expect(page).to have_content('30.62€ in total')
  end
end
