module API::V1
  class Account < Grape::API
    # GET: /api/v1/accounts/keep.
    desc 'Get Keep Accounts for user',
         is_array: true,
         success: Entities::KeepAccount
    get '/accounts/keep' do
      present KeepAccount.where(user_uid: uid), with: Entities::KeepAccount
    end

    desc 'Create Keep Account',
         success: Entities::KeepAccount
    params do
      requires :name,
               type: String,
               desc: 'Account name.'
      optional :base_currency,
               type: String,
               default: 'usd',
               values: CurrencyRatesService.currencies
      optional :initial_balance,
               type: BigDecimal,
               default: 0.to_d,
               values: 0.to_d..10**10.to_d
    end
    post '/accounts/keep' do
      ka = KeepAccount.create!(
        user_uid: uid,
        name: params[:name],
        base_currency: params[:base_currency]
      )
      unless params[:initial_balance].zero?
        ka.create_initial_income!(params[:initial_balance])
      end
      present ka, with: Entities::KeepAccount
    end

    desc 'Get Expense Accounts for user',
         is_array: true,
         success: Entities::ExpenseAccount
    get '/accounts/expense' do
      present ExpenseCategory.where(user_uid: uid), with: Entities::ExpenseAccount
    end

    desc 'Create Expense Account',
         success: Entities::ExpenseAccount
    params do
      requires :name,
               type: String,
               desc: 'Account name.'
      optional :base_currency,
               type: String,
               default: 'usd',
               values: CurrencyRatesService.currencies.yield_self { |codes| codes.map(&:upcase) + codes.map(&:downcase) }
      optional :month_expenses_limit,
               type: BigDecimal,
               default: 0.to_d
    end
    post '/accounts/expense' do
      ExpenseCategory.create!(
        user_uid: uid,
        name: params[:name],
        base_currency: params[:base_currency],
        month_expenses: params[:month_expenses_limit]
      ).tap { |ec| present ec, with: Entities::ExpenseAccount }
    end
  end
end
