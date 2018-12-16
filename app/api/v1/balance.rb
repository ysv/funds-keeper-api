module API::V1
  class Balance < Grape::API
    desc 'Get user balances',
         success: Entities::Balances
    get '/balances' do
      month_start = Time.now.beginning_of_month
      total_income = ::Income.total_by(user_uid: uid)
      total_expense = ::Expense.total_by(user_uid: uid)
      resp =
        {
          balance: total_income - total_expense,
          nickname: uid,
          income: {
            month: ::Income.total_by(user_uid: uid, from: month_start),
            total: total_income
          },
          expense: {
            month: ::Expense.total_by(user_uid: uid, from: month_start),
            total: total_expense
          }
        }
      present OpenStruct.new(resp), with: Entities::Balances
    end
  end
end
