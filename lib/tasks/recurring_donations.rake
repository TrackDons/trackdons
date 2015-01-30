namespace :recurring_donations do
  desc 'Creates recurring donations for today'
  task :create_for_today => :environment do
    RecurringDonation.create_today_donations
  end
end
