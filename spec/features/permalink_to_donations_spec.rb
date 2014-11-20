require 'rails_helper'

RSpec.feature 'wadus' do
  scenario 'creates a project' do
    a = create_project
    expect(a.name).to eq('Wikiwadus')
  end
end