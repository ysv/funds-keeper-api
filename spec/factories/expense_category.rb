FactoryBot.define do
  factory :expense_category do
    name { Faker::Vehicle.unique.make_and_model }
    base_currency { CurrencyRatesService.currencies.sample }
    user_uid { Faker::Auth.uid }

    trait :month_expense_limit do
      month_expenses { generate(:expense_limit) }
    end

    factory :expense_category_with_limit, traits: [:month_expense_limit]
  end
end

# == Schema Information
# Schema version: 20181202202047
#
# Table name: expense_categories
#
#  id             :bigint(8)        not null, primary key
#  name           :string(255)      not null
#  user_uid       :string(25)       not null
#  base_currency  :string(10)       default("usd"), not null
#  month_expenses :decimal(12, 2)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_expense_categories_on_name_and_user_uid  (name,user_uid) UNIQUE
#
