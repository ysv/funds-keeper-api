FactoryBot.define do
  factory :income do
    keep_account { create(:keep_account_with_balance) }
    description { Faker::Lorem.sentence }

    after(:create) do |income|
      income.record_operation!(generate(:income_amount))
    end
  end
end

# == Schema Information
# Schema version: 20181202211259
#
# Table name: incomes
#
#  id              :bigint(8)        not null, primary key
#  description     :string(255)
#  keep_account_id :bigint(8)
#  recorded_at     :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_incomes_on_keep_account_id  (keep_account_id)
#
