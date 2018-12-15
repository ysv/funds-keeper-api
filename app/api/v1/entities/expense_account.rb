module API::V1
  module Entities
    class ExpenseAccount < KeepAccount
      expose :month_expenses,
             as: :month_expenses_limit,
             documentation: {
               desc: 'Account Month Expenses Limit',
               type: String,
             }
    end
  end
end
