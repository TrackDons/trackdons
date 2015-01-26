require 'rails_helper'

RSpec.feature 'Projects navigation' do
  background do
    health = create_category(name: 'Health')

    create_project name: 'Cruz Roja', category: health
    create_project name: 'Médicos Sin Fronteras', category: health
  end

  scenario 'I should be able to filter by Alphabetic order' do
    visit projects_page

    expect(page).to have_css(".project:nth-child(2) a", text: "Médicos Sin Fronteras")
    expect(page).to have_css(".project:nth-child(3) a", text: "Cruz Roja")

    click_link "Alpha"

    expect(page).to have_css(".project:nth-child(2) a", text: "Cruz Roja")
    expect(page).to have_css(".project:nth-child(3) a", text: "Médicos Sin Fronteras")

    click_link "Latest"

    expect(page).to have_css(".project:nth-child(2) a", text: "Médicos Sin Fronteras")
    expect(page).to have_css(".project:nth-child(3) a", text: "Cruz Roja")
  end
end
