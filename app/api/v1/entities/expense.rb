module API::V1
  module Entities
    class Expense < Grape::Entity
      expose :base_amount,
             documentation: {
               desc: 'Expense Amount in Keep Account Currency.',
               type: String,
             }

      expose :base_currency,
             documentation: {
               desc: 'Currency of Keep Account.',
               type: String,
             }

      expose :quote_amount,
             documentation: {
               desc: 'Expense Amount in Expense Account Currency.',
               type: String,
             }

      expose :quote_currency,
             documentation: {
               desc: 'Currency of Expense Account.',
               type: String,
             }

      expose(:keep_account,
             documentation: {
               desc: 'Keep Account Name.',
               type: String
             }) { |income| income.keep_account.name }

      expose(:expense_account,
             documentation: {
               desc: 'Expense Account Name.',
               type: String
             }) { |expense| expense.expense_category.name }

      expose :description,
             documentation: {
               desc: 'Expense Transaction description.',
               type: String
             }

      # TODO: Check that it's String.
      expose :recorded_at,
             documentation: {
               desc: 'Expense Transaction date',
               type: String
             }
    end
  end
end
