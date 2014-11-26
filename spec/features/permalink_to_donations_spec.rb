require 'rails_helper'

RSpec.feature 'Sharing donations. When I create a donation' do
  background do
    @project = create_project(:name => 'Wikiwadus')
    @user = create_user(name: 'Yorch', password: 'wadusm4n', :email => "yorch@example.com")
  end
  
  scenario 'I see a success page and message' do
    visit '/login'
    
    fill_in 'Email', :with => "yorch@example.com"
    fill_in 'Password', :with => "wadusm4n"
    
    click_button 'Log in'
    
    visit '/projects'
    
    click_link('Wikiwadus')
        
    fill_in 'donation_date', :with => "2014-10-10"
    fill_in 'donation_quantity_cents', :with => "200"
    click_button 'TrackDon'
    
    expect(page).to have_content 'Hooray! Your donation is tracked. You can share it with your friends to encourage them to donate as well'
    expect(page).to have_content 'Yorch donated 200€ to Wikiwadus'
  end
  
  scenario 'I can share a link to my donation via email, twitter or facebook' do
    visit '/login'
    
    fill_in 'Email', :with => "yorch@example.com"
    fill_in 'Password', :with => "wadusm4n"
    
    click_button 'Log in'
    
    visit '/projects'
    
    click_link('Wikiwadus')
    
    fill_in 'donation_date', :with => "2014-10-10"
    fill_in 'donation_quantity_cents', :with => "200"
    click_button 'TrackDon'
    
    tracked_don = Donation.last
    
    expect(find_link('Share by email')[:href]).to match(/^mailto\:\?subject=.*&body=.*donations%2F#{tracked_don.id}/)
    expect(find_link('Share in Twitter')[:href]).to match(/https\:\/\/twitter\.com\/home\?status\=.*donations%2F#{tracked_don.id}/)
    expect(find_link('Share in Facebook')[:href]).to match(/http\:\/\/www\.facebook\.com\/sharer\/sharer\.php\?u\=.*donations%2F#{tracked_don.id}/)
  end
  
  scenario 'Anonymous users can access a donation page, but does not see share links' do
    donation = create_donation(:user => @user, :project => @project, :quantity_cents => 200)
    
    visit donation_page(donation)
    
    expect(page).not_to have_content('Hooray!')
    expect(page).to have_content 'Yorch donated 200€ to Wikiwadus'
  end
  
  scenario 'Users can see related links' do
    donation = create_donation(:user => @user, :project => @project, :quantity_cents => 200)
    
    visit donation_page(donation)
    expect(page).to have_link 'Wikiwadus project page', :href => project_path(@project)
    expect(page).to have_link 'More donations by Yorch', :href => user_path(@user)
    expect(page).to have_link 'Other projects', :href => projects_path
  end
end