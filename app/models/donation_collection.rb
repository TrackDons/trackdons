class DonationCollection
  def self.all(options = {})
    (single_donations(options) + recurring_donations(options)).
      sort{|b,a| a.date <=> b.date }
  end

  def self.single_donations(options)
    donations = Donation.single.includes(:project, :user)
    if options[:project]
      donations = donations.where(project_id: options[:project].id)
    end

    if options[:user]
      donations = donations.where(user_id: options[:user].id)
    end

    donations.all
  end

  def self.recurring_donations(options)
    donations = RecurringDonation.includes(:project, :user)

    if options[:project]
      donations = donations.where(project_id: options[:project].id)
    end

    if options[:user]
      donations = donations.where(user_id: options[:user].id)
    end

    donations.all
  end
end
