class CurrencyRatesService

  attr_accessor :base

  class << self
    def currencies
      ["USD", "BGN", "CAD", "BRL", "HUF", "DKK", "JPY", "ILS", "TRY", "RON", "GBP", "PHP", "HRK", "NOK", "ZAR", "MXN", "AUD", "USD", "KRW", "HKD", "EUR", "ISK", "CZK", "THB", "MYR", "NZD", "PLN", "CHF", "SEK", "CNY", "SGD", "INR", "IDR", "RUB"]
    end
  end

  def initialize(base)
    @base = base.upcase.to_s
  end

  def cache_key
    "#{base}-rates"
  end

  def rate(quote)
    quote = quote.upcase.to_s
    get_rates.fetch(quote)
  end

  private

  def get_rates
    cache.fetch cache_key, expires_in: 5.minutes do
      http_send.fetch('rates')
    end
  end

  def cache
    Rails.cache
  end

  def http_send
    response = Faraday.new(rates_endpoint).get do |req|
      req.params['base'] = base
    end
    JSON.parse(response.body)
  end

  def rates_endpoint
    "https://api.exchangeratesapi.io/latest"
  end
end