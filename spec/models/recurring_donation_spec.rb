require 'rails_helper'

RSpec.describe RecurringDonation, type: :model do
  let(:user) { create_user }
  let(:project) { create_project }

  before do
    Timecop.freeze Time.parse('2015-1-30')
  end

  describe '#next_donation_date' do
    it 'should calculate the next donation date' do
      recurring_donation = create_recurring_donation({
        frequency_units: 3, frequency_period: 'months',
        date: Date.parse('2014-1-1')
      })

      expect(recurring_donation.next_donation_date).to eq(Date.parse('2015-4-1'))
    end

    it 'should consider today as the current paying day' do
      Timecop.freeze Time.parse('2015-1-31')

      recurring_donation = create_recurring_donation({
        frequency_units: 1, frequency_period: 'months',
        date: Date.parse('2014-12-31')
      })

      expect(recurring_donation.next_donation_date).to eq(Date.parse('2015-1-31'))
    end

    it 'should consider shorter months' do
      Timecop.freeze Time.parse('2015-2-1')

      recurring_donation = create_recurring_donation({
        frequency_units: 1, frequency_period: 'months',
        date: Date.parse('2014-12-31')
      })

      expect(recurring_donation.next_donation_date).to eq(Date.parse('2015-2-28'))
    end
  end

  describe '.create_today_donations' do
    let!(:recurring_donation) do
      create_recurring_donation({
        user: user, project: project, quantity: 30, currency: 'EUR',
        frequency_units: 1, frequency_period: 'months',
        date: Date.parse('2014-12-30')
      })
    end

    context 'when no donation exist' do
      it 'should create the donations for today date' do
        expect(project.donations.count).to be(0)

        described_class.create_today_donations

        project.donations.reload
        expect(project.donations.count).to be(1)

        donation = project.donations.first
        expect(donation.user).to eq(recurring_donation.user)
        expect(donation.currency).to eq(recurring_donation.currency)
        expect(donation.quantity_cents).to eq(recurring_donation.quantity_cents)
        expect(donation.date).to eq(Date.today)
      end
    end

    context 'when donations already exist' do
      it 'should not create any duplicated donation' do
        expect(project.donations.count).to be(0)

        described_class.create_today_donations

        project.donations.reload
        expect(project.donations.count).to be(1)

        described_class.create_today_donations

        project.donations.reload
        expect(project.donations.count).to be(1)
      end
    end

    context "when recurring donation date date is a day that don't exist in all months" do
      it 'should create the donations' do
        Timecop.freeze Time.parse('2015-2-28')

        expect(project.donations.count).to be(0)

        described_class.create_today_donations

        project.donations.reload
        expect(project.donations.count).to be(1)
      end
    end
  end
end
