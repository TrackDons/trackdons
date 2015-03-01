require 'rails_helper'

RSpec.feature 'User donations' do
  background do
    @project = create_project(:name => 'Wikiwadus')
    @user = create_user(name: 'Yorch', password: 'wadusm4n', email: "yorch@example.com")

    create_donation project: @project, quantity: 20.12, date: Date.today, user: @user, comment: 'This is my comment'
  end

  scenario 'I see the total amount of donations' do
    create_donation project: @project, quantity: 10.50, date: 32.days.ago, user: @user
    login_as "yorch@example.com", "wadusm4n"

    expect(page).to have_content('20.12€ donated in the last month')
    expect(page).to have_content('30.62€ in total')
  end

  scenario "I see the total amount of donations don't include private donations when viewed by other user" do
    other_user = create_user(name: 'Bruce', email: "bruce@example.com")

    create_donation project: @project, quantity: 20.12, date: Date.today,  user: other_user, comment: 'This is my comment'
    create_donation project: @project, quantity: 10.50, date: 32.days.ago, user: other_user
    create_donation project: @project, quantity: 10,    date: 2.days.ago,  user: other_user, quantity_privacy: true

    login_as "yorch@example.com", "wadusm4n"
    visit user_page(other_user)

    expect(page).to have_content('20.12€ donated in the last month')
    expect(page).to have_content('30.62€ in total')
  end

  scenario 'I see the total amount of donations including private donations' do
    create_donation project: @project, quantity: 10.50, date: 32.days.ago, user: @user
    create_donation project: @project, quantity: 10,    date: 2.days.ago,  user: @user, quantity_privacy: true

    login_as "yorch@example.com", "wadusm4n"

    expect(page).to have_content('30.12€ donated in the last month')
    expect(page).to have_content('40.62€ in total')
  end

  scenario 'I can delete a donation of mine' do
    other_user = create_user(name: 'Bruce', email: "bruce@example.com")
    create_donation project: @project, quantity: 20.12, date: Date.today, user: other_user

    visit project_page(@project)

    expect(page).to_not have_content('Delete')

    login_as "yorch@example.com", "wadusm4n"

    click_link('Delete')

    expect(page).to_not have_content('A donation by Bruce')
    #expect(page).to have_content('0€ in total')
  end

  scenario 'I can edit a donation of mine' do
    login_as "yorch@example.com", "wadusm4n"

    visit project_page(@project)

    within(:css, '.donation') do
      click_link('Edit')
    end

    fill_in 'How much?', :with => '25'
    fill_in 'When did you donate?', :with => '2013-10-10'
    uncheck 'i_want_to_explain'
    click_button 'Update'

    expect(page).to have_css('h1', text: 'Wikiwadus')
    expect(page).to_not have_content('This is my comment')

    visit user_page(@user)

    expect(page).to have_content('0€ donated in the last month')
    expect(page).to have_content('25€ in total')
  end

end
