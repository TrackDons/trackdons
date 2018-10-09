require 'rails_helper'

RSpec.feature 'Projects navigation' do
  background do
    health = create_category(name_translations: {en: 'Health'})

    @user = create_user(name: 'Marlo', email: "marlo@muchachada.nui")

    @other_user = create_user(name: 'Claudio', email: "claudio@muchachada.nui")

    @cruz_roja = create_project name: 'Cruz Roja', category: health, countries: ['US', 'ES']
    @medicos = create_project name: 'Médicos Sin Fronteras', category: health, countries: ['ES']
    @wikipedia = create_project name: 'Wikipedia', countries: ['ES']

    create_donation project: @cruz_roja, quantity: 20, date: Date.today, user: @user, quantity_privacy: true
    create_donation project: @cruz_roja, quantity: 30, date: Date.today, user: @other_user
    create_donation project: @wikipedia, quantity: 10, date: Date.today, user: @other_user, quantity_privacy: true

  end

  scenario 'I should be able to filter by Alphabetic order' do
    visit projects_page

    expect(page).to have_css(".project:nth-child(2) a", text: "Wikipedia")
    expect(page).to have_css(".project:nth-child(3) a", text: "Médicos Sin Fronteras")
    expect(page).to have_css(".project:nth-child(4) a", text: "Cruz Roja")

    click_link "Alpha"

    expect(page).to have_css(".project:nth-child(2) a", text: "Cruz Roja")
    expect(page).to have_css(".project:nth-child(3) a", text: "Médicos Sin Fronteras")
    expect(page).to have_css(".project:nth-child(4) a", text: "Wikipedia")

    click_link "Latest"

    expect(page).to have_css(".project:nth-child(2) a", text: "Wikipedia")
    expect(page).to have_css(".project:nth-child(3) a", text: "Médicos Sin Fronteras")
    expect(page).to have_css(".project:nth-child(4) a", text: "Cruz Roja")

    click_link "Popular"

    expect(page).to have_css(".project:nth-child(2) a", text: "Cruz Roja")
    expect(page).to have_css(".project:nth-child(3) a", text: "Wikipedia")
    expect(page).to have_css(".project:nth-child(4) a", text: "Médicos Sin Fronteras")
  end

  scenario 'I should be able to filter by Category' do
    visit projects_page

    expect(page).to have_css(".project:nth-child(2) a", text: "Wikipedia")
    expect(page).to have_css(".project:nth-child(3) a", text: "Médicos Sin Fronteras")
    expect(page).to have_css(".project:nth-child(4) a", text: "Cruz Roja")

    click_link "Health"

    expect(page).to have_css(".project:nth-child(2) a", text: "Médicos Sin Fronteras")
    expect(page).to have_css(".project:nth-child(3) a", text: "Cruz Roja")
  end

  scenario 'I should be able to filter by Country' do
    visit projects_page

    expect(page).to have_css(".project:nth-child(2) a", text: "Wikipedia")
    expect(page).to have_css(".project:nth-child(3) a", text: "Médicos Sin Fronteras")
    expect(page).to have_css(".project:nth-child(4) a", text: "Cruz Roja")

    click_link "United States"

    expect(page).to have_css(".project:nth-child(2) a", text: "Cruz Roja")
  end
end
