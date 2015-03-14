module LoginHelpers
  def login_as(email, password)
    visit home_page

    within(:css, '#new_session') do
      fill_in 'Email', with: email
      fill_in 'Password', with: password

      click_button 'Log in'
    end
  end
end

RSpec.configure do |c|
  c.include LoginHelpers
end
