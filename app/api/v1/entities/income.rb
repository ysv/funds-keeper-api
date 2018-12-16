module API::V1
  module Entities
    class Income < Grape::Entity
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

# == Schema Information
# Schema version: 20181202211259
#
# Table name: expenses
#
#  id                  :bigint(8)        not null, primary key
#  description         :string(255)
#  keep_account_id     :bigint(8)
#  expense_category_id :bigint(8)
#  recorded_at         :datetime
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_expenses_on_expense_category_id  (expense_category_id)
#  index_expenses_on_keep_account_id      (keep_account_id)
#
