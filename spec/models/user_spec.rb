require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'creation currency assignment' do
    it 'should assign EUR currency for european countries' do
      user = create_user country: 'ES'
      expect(user.currency).to eq('EUR')
    end

    it 'should assign USD currency for non european countries' do
      user = create_user country: 'NZ'
      expect(user.currency).to eq('USD')
    end
  end
end
