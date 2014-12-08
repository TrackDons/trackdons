class CurrencyFromCountry
  def initialize(country_code)
    @currency = COUNTRY_MAPPING[country_code] || 'USD'
  end

  attr_reader :currency

  private

  # Based on this list: http://www.wikiwand.com/es/Eurozona
  COUNTRY_MAPPING = {
    'GE' => 'EUR',
    'AT' => 'EUR',
    'BE' => 'EUR',
    'ES' => 'EUR',
    'FI' => 'EUR',
    'FR' => 'EUR',
    'IE' => 'EUR',
    'IT' => 'EUR',
    'LU' => 'EUR',
    'NL' => 'EUR',
    'PT' => 'EUR'
  }
end
