module Accounts
  class Expense < Account

  end
end

# == Schema Information
# Schema version: 20181202200448
#
# Table name: expenses
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
#  index_expenses_on_name_and_user_uid  (name,user_uid) UNIQUE
#
