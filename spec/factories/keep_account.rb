FactoryBot.define do
  factory :keep_account do
    name { Faker::Bank.name }
    base_currency { CurrencyRatesService.currencies.sample }
    user_uid { Faker::Auth.uid }

    trait :with_initial_balance do
      after(:create) do |ka|
        ka.create_initial_income(Faker::Number.decimal(12, 2))
      end
    end
  end
end

# == Schema Information
# Schema version: 20181202202047
#
# Table name: keep_accounts
#
#  id            :bigint(8)        not null, primary key
#  name          :string(255)      not null
#  user_uid      :string(25)       not null
#  base_currency :string(10)       default("usd"), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_keep_accounts_on_name_and_user_uid  (name,user_uid) UNIQUE
#