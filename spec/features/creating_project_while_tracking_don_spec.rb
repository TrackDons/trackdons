require 'rails_helper'

RSpec.feature 'Adding projects while tracking donations. When I create a donation' do
  background do
    @project = create_project(:name => 'Wikiwadus')
    @user = create_user(name: 'Yorch', password: 'wadusm4n', :email => "yorch@example.com")
  end
  
  scenario 'As a logged in user, I should be able to create a new project on the fly' do
    visit '/login'
    
    fill_in 'Email', :with => "yorch@example.com"
    fill_in 'Password', :with => "wadusm4n"
    
    click_button 'Log in'
    
    visit '/'
    
    find('#donation_project_attributes_name').set 'Ngrok'
    
    fill_in 'Project Description', :with => 'Introspected tunnels to localhost'
    fill_in 'URL', :with => 'https://ngrok.com/'
    
    fill_in 'When did you donate?', :with => '2014-10-10'
    fill_in 'How much?', :with => '25'
    
    click_button 'TrackDon'
    
    expect(page).to have_content 'Hooray!'
    expect(page).to have_content '25€ to Ngrok by Yorch'
    
  end
  
  scenario 'As an anonymous user, I should be able to create a new project on the fly' do
    visit '/'
    
    find('#donation_project_attributes_name').set 'Ngrok'
    
    fill_in 'Project Description', :with => 'Introspected tunnels to localhost'
    fill_in 'URL', :with => 'https://ngrok.com/'
    
    fill_in 'When did you donate?', :with => '2014-10-10'
    fill_in 'How much?', :with => '25'
    
    click_button 'TrackDon'
    
    expect(page).to have_content 'Woooa! Congratulations'
    fill_in 'Name',         :with => "Luke Skywalker"
    fill_in 'Email',        :with => "luke@example.com"
    fill_in 'Password',     :with => 'lukeskywalk3r'
    fill_in 'Confirmation', :with => 'lukeskywalk3r'
    select 'Spain', :from => 'Country'
    
    click_button 'Create my account'
        
    expect(page).to have_content 'Hey, donation tracked, and you have your profile ready to keep tracking donations!'
  end
end
