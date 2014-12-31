require 'rails_helper'

RSpec.feature 'User donations' do
  background do
    @project = create_project(:name => 'Wikiwadus')
    @user = create_user(name: 'Yorch', password: 'wadusm4n', email: "yorch@example.com")

    create_donation project: @project, quantity: 20.12, date: Date.today, user: @user
  end

  scenario 'I see the total amount of donations' do
    create_donation project: @project, quantity: 10.50, date: 32.days.ago, user: @user
    login_as "yorch@example.com", "wadusm4n"

    expect(page).to have_content('20.12€ donated in the last month')
    expect(page).to have_content('30.62€ in total')
  end

  scenario 'I can delete a donation of mine' do
    other_user = create_user(name: 'Bruce', email: "bruce@example.com")
    create_donation project: @project, quantity: 20.12, date: Date.today, user: other_user

    visit '/projects/wikiwadus'

    expect(page).to_not have_content('Delete')

    login_as "yorch@example.com", "wadusm4n"

    click_link('Delete')

    expect(page).to have_content('0€ donated in the last month')
    expect(page).to have_content('0€ in total')
  end
end
