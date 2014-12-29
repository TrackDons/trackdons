module MoneyHelper

  def donation_quantity_currency(donation)
    money(donation.quantity)
  end

  def money(money, options = {})
    default_options = {
      with_currency: false,
      no_cents_if_whole: true
    }

    # EUR amounts render the symbol after the amount
    if money.currency == :eur
      default_options.merge!(symbol_position: :after, symbol_after_without_space: true)
    # USD amounts render the symbol before the amount
    elsif money.currency == :usd
      default_options.merge!(symbol_before_without_space: true)
    end

    options = default_options.merge(options)

    money.format(options)
  end
end
