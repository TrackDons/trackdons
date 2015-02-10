module ChartData
  extend ActiveSupport::Concern

  def chart_data(current_user)
    plain_donations = user_donations(current_user).select(:quantity_cents, :currency, :date)

    return "[]" if plain_donations.empty?

    values = {}
    plain_donations.group_by{|d| d.date.year }.each do |year, donations|
      values[year] = donations.map(&:quantity).inject(&:+).exchange_to(self.currency)
    end

    sorted_values = values.keys.sort.map{ |year| values[year].to_i }

    return "[" + sorted_values.join(",") + "]"
  end

  private

  def user_donations(current_user)
    @user_donations ||= begin
      if current_user == self
        self.donations
      else
        self.donations.visible
      end
    end
  end
end
