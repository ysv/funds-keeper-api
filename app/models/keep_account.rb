class KeepAccount < ApplicationRecord
  include HasManyOperations
  has_many :incomes
  has_many :expenses

  validates :name, uniqueness: { scope: %i[user_uid] }

  def create_initial_income!(amount)
    income = Income.create!(
      keep_account: self,
      description: 'Initial account balance income'
    )
    income.record_operation!(amount)
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
