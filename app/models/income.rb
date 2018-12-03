class Income < ApplicationRecord
  attribute :recorded_at, :datetime, default: -> { Time.now }

  belongs_to :keep_account
  has_one :income_operation, as: :parent, class_name: 'Operation'

  def record_operation!(amount)
    Operation.create(credit: amount, parent: self, account: keep_account)
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
