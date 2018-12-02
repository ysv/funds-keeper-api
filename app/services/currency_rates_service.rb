class CurrencyRatesService

  attr_accessor :base

  def initialize(base)
    @base = base.upcase.to_s
  end

  def cache_key
    "#{base}-currency-rates"
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