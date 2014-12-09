require 'rails_helper'

RSpec.feature 'Adding projects while tracking donations. When I create a donation' do
  background do
    @project = create_project(:name => 'Wikiwadus')
    @user = create_user(name: 'Yorch', password: 'wadusm4n', :email => "yorch@example.com")
  end
  
  scenario 'I should be able to create a new project on the fly' do
    visit '/login'
    
    fill_in 'Email', :with => "yorch@example.com"
    fill_in 'Password', :with => "wadusm4n"
    
    click_button 'Log in'
    
    visit '/'
    
    # fill_in 'donation_project_name', :with => 'Ngrok' # (this doesn't work cos it is a hidden field for select2)
    find('#donation_project_name').set 'Ngrok'
    
    fill_in 'Project Description', :with => 'Introspected tunnels to localhost'
    fill_in 'URL', :with => 'https://ngrok.com/'
    
    fill_in 'When did you donate?', :with => '2014-10-10'
    fill_in 'How much?', :with => '25'
    
    click_button 'TrackDon'
    
    expect(page).to have_content 'Hooray!'
    expect(page).to have_content 'Yorch donated 25€ to Ngrok'
    
  end
end