# encoding : utf-8

MoneyRails.configure do |config|
  # Use live currency conversion
  # config.default_bank = EuCentralBank.new

  # Disallow live currency conversion
  # Money.disallow_currency_conversion!

  # Rates from the 6th of December, 2014
  config.add_rate "USD", "EUR", 0.81393
  config.add_rate "EUR", "USD", 1.22860

  config.include_validations = true
  config.no_cents_if_whole = true
  config.symbol = true
end
