require 'rails_helper'

RSpec.feature 'Projects fans' do
  background do
    @user = create_user(name: 'Yorch', password: 'wadusm4n', email: "yorch@example.com")

    health = create_category(name: 'Health')

    create_project name: 'Cruz Roja', category: health, countries: ['US', 'ES']
  end

  scenario 'I should be redirected to login page if I try to follow a project' do
    visit projects_page

    click_link "Cruz Roja"
    click_link "Follow"

    expect(page).to have_content('Login to TrackDons')
  end

  scenario 'I should be able to follow a project and unfollow it' do
    login_as "yorch@example.com", "wadusm4n"

    visit projects_page

    click_link "Cruz Roja"
    click_link "Follow"

    expect(page).to have_css(:a, text: 'Following')

    within(:css, '#container') do
      click_link 'Hello Yorch'
    end

    within(:css, '.sidebar') do
      expect(page).to have_content('Cruz Roja')
    end

    click_link('Cruz Roja')
    click_link('Following')

    within(:css, '#container') do
      click_link 'Hello Yorch'
    end

    within(:css, '.sidebar') do
      expect(page).to_not have_content('Cruz Roja')
    end
  end

end
