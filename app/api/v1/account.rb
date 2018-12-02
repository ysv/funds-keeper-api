module API::V1
  class Account
    desc 'Get User Accounts'
    get '/accounts' do

    end

    desc 'Create Keep/Expense Account'
    params do
      requires :type,
               type: String,
               values: %i[keep expense],
               desc: 'Account type.'
      requires :name,
               type: String,
               desc: 'Account name.'
      optional :base_currency,
               type: String,
               values: %i[]
    end
  end
end