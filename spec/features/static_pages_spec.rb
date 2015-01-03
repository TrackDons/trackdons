require 'rails_helper'

RSpec.feature 'Static pages' do
  scenario 'Visit about page' do
    visit home_page

    within(:css, '#container') do
      click_link 'About'
    end

    expect(page).to have_content('About TrackDons')
  end
end
