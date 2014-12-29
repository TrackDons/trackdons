require 'rails_helper'

RSpec.feature 'Donating projects without being logged in' do
  background do
    @project = create_project(:name => 'Wikiwadus')
    @user = create_user(name: 'Yorch', password: 'wadusm4n', :email => "yorch@example.com")
  end

  scenario 'As an anonymous user, I should be able to donate to a project and see the donation after log in' do
    visit '/'

    find('#donation_project_attributes_name').set 'Wikiwadus'

    fill_in 'When did you donate?', :with => '2014-10-10'
    fill_in 'How much?', :with => '25'

    click_button 'TrackDon'

    expect(page).to have_content 'Woooa! Congratulations'

    login_as "yorch@example.com", "wadusm4n"

    expect(page).to have_content 'Hey, donation tracked'
    expect(page).to have_content '25€ to Wikiwadus by Yorch'
  end
end
