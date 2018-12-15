FactoryBot.define do
  factory :expense do
    keep_account { create(:keep_account_with_balance) }
    expense_category { create(:expense_category_with_limit) }

    description { Faker::Lorem.sentence }

    after(:create) do |income|
      income.record_operations!(
        base_amount: generate(:expense_amount),
        quote_amount: generate(:expense_amount)
      )
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
