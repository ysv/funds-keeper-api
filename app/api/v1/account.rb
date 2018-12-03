module API::V1
  class Account < Grape::API
    desc 'Get Keep Accounts for user'
    get '/accounts/keep' do
      KeepAccount.where(user_uid: uid)
    end

    desc 'Create Keep Account'
    params do
      requires :name,
               type: String,
               desc: 'Account name.'
      optional :base_currency,
               type: String,
               default: 'usd',
               values: CurrencyRatesService.currencies.yield_self { |codes| codes.map(&:upcase) + codes.map(&:downcase) }
      optional :initial_balance,
               type: BigDecimal,
               default: 0.to_d
    end
    post '/accounts/keep' do
      ka = KeepAccount.create!(
        user_uid: uid,
        name: params[:name],
        base_currency: params[:base_currency]
      )
      unless params[:initial_balance].zero?
        income = Income.create!(keep_account: ka, description: 'Initial account balance income')
        income.record_operation!(params[:initial_balance])
      end
      ka
    end


    ### EXPENSE !!!
    desc 'Get Expense Accounts for user'
    get '/accounts/expense' do
      ExpenseCategory.where(user_uid: uid)
    end

    desc 'Create Expense Account'
    params do
      requires :name,
               type: String,
               desc: 'Account name.'
      optional :base_currency,
               type: String,
               default: 'usd',
               values: CurrencyRatesService.currencies.yield_self { |codes| codes.map(&:upcase) + codes.map(&:downcase) }
      optional :month_expenses,
               type: BigDecimal,
               default: 0.to_d
    end
    post '/accounts/expense' do
      ExpenseCategory.create!(
        user_uid: uid,
        name: params[:name],
        base_currency: params[:base_currency]
      )
    end
  end
end