require 'rails_helper'

RSpec.feature 'Tracking a donations from project page' do
  scenario 'Shows a success message' do
    create_project(:name => 'Wikiwadus')
    user = create_user(:password => "wadusm4n")
    visit '/login'
    
    fill_in 'Email', :with => user.email
    fill_in 'Password', :with => "wadusm4n"
    
    click_button 'Log in'
    
    visit '/projects'
    
    click_link('Wikiwadus')
        
    fill_in 'donation_date', :with => "2014-10-10"
    fill_in 'donation_quantity_cents', :with => "200"
    click_button 'TrackDon'
    
    expect(page).to have_content 'Donation created! You are amazing'
  end
end