require 'rails_helper'

RSpec.describe Project do
  describe 'twitter setter method' do
    it 'should keep only the username when it is an URL' do
      subject.twitter = 'https://twitter.com/cruzroja'
      expect(subject.twitter).to eq('cruzroja')
    end

    it 'it should remove the @ from the value provided' do
      subject.twitter = '@cruzroja'
      expect(subject.twitter).to eq('cruzroja')
    end
  end
end
