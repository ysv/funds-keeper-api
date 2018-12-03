module API::V1
  class Income < Grape::API
    desc 'Get User incomes'
    params do
      optional :account_name,
               type: String,
               desc: 'Account name for filtering incomes.'
    end
    get '/income' do
      ka = KeepAccount.where(user_uid: uid)
      ka = ka.where(name: params[:account_name]) if params[:account_name].present?
      ::Income.where(keep_account: ka)
    end

    desc 'Record User income'
    params do
      requires :account_name,
              type: String,
              desc: 'Account name where income will be recorded to.'
      requires :amount,
              type: BigDecimal,
              desc: 'Income amount.',
              values: 0.to_d..10**10.to_d
      optional :description,
               type: String,
               default: '',
               desc: 'Income operation description.'
      optional :date,
               type: Time,
               default: ->{ Time.now },
               desc: 'Income operation time.'
    end
    post '/income' do
      ka = KeepAccount.find_by!(user_uid: uid, name: params[:account_name])
      ka.transaction do
        income = ::Income.create!(
          description: params[:description],
          recorded_at: params[:date],
          keep_account: ka)
        income.record_operation!(params[:amount])
      end
    end
  end
end