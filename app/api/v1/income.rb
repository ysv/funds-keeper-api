module API::V1
  class Income < Grape::API
    desc 'Get User incomes',
         is_array: true,
         success: Entities::Income
    params do
      optional :account_name,
               type: String,
               desc: 'Account name for filtering incomes.'
    end
    get '/incomes' do
      ka = KeepAccount.where(user_uid: uid)
      ka = ka.find_by!(name: params[:account_name]) if params[:account_name].present?
      present ::Income.where(keep_account: ka), with: Entities::Income
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
    post '/incomes' do
      ka = KeepAccount.find_by!(user_uid: uid, name: params[:account_name])
      income = ::Income.new(
        description: params[:description],
        recorded_at: params[:date],
        keep_account: ka
      )
      income.transaction do
        income.save!
        income.record_operation!(params[:amount])
      end
      present income, with: Entities::Income
    end
  end
end
