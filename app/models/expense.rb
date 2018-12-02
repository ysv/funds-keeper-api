class Expense < ApplicationRecord
  attribute :recorded_at, :datetime, default: -> { Time.now }

  belongs_to :keep_account
  belongs_to :expense_category

  has_one :income_operation, as: :parent
  has_one :expense_operation, as: :parent
end

# == Schema Information
# Schema version: 20181202211259
#
# Table name: expenses
#
#  id                  :bigint(8)        not null, primary key
#  amount              :decimal(12, 2)   not null
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
