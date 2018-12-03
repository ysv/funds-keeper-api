class Expense < ApplicationRecord
  attribute :recorded_at, :datetime, default: -> { Time.now }

  belongs_to :keep_account
  belongs_to :expense_category

  has_one :income_operation, -> { where(credit: 0)}, as: :parent, class_name: 'Operation'
  has_one(:expense_operation, -> { where(debit: 0)}, as: :parent, class_name: 'Operation')

  def record_operations!(base_amount:, quote_amount:)
    transaction do
      Operation.create(debit: base_amount, parent: self, account: keep_account)
      Operation.create(credit: quote_amount, parent: self, account: expense_category)
    end
  end

  class << self
    def total_by(user_uid:, from: nil, to: nil)
      ka = KeepAccount.where(user_uid: user_uid)
      op = Operation.where(account: ka)
      op = op.where('recorded_at > ?', from) if from.present?
      op = op.where('recorded_at < ?', to) if to.present?
      op.sum(:debit)
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
