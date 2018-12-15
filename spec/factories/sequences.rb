FactoryBot.define do
  sequence(:income_amount) { Faker::Number.decimal(2, 2).to_d + 1 }
  sequence(:expense_amount) { Faker::Number.decimal(2, 2).to_d + 1 }

  sequence(:balance) { Faker::Number.decimal(4, 2).to_d + 1 }
  sequence(:expense_limit) { Faker::Number.decimal(4, 2).to_d + 1 }
end
