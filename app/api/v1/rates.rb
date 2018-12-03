module API::V1
  class Rates < Grape::API
    desc 'Get currency rates'
    params do
      requires :base,
               type: String,
               values: CurrencyRatesService.currencies
      requires :quote,
               type: String,
               values: CurrencyRatesService.currencies
      end
    get '/rates' do
      CurrencyRatesService.new(params[:base]).rate(params[:quote])
    end
  end
end
