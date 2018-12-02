class ExpenseCategory < ApplicationRecord
  include HasManyOperations
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
