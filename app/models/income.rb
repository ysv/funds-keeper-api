class Income < ApplicationRecord
  attribute :recorded_at, :datetime, default: -> { Time.now }

  belongs_to :keep_account
  has_one :income_operation, as: :parent, class_name: 'Operation'

  delegate :base_currency, to: :keep_account

  def base_amount
    income_operation.credit
  end

  def record_operation!(amount)
    Operation.create(credit: amount, parent: self, account: keep_account)
  end

  class << self
    def total_by(user_uid:, from: nil, to: nil)
      ka = KeepAccount.where(user_uid: user_uid)
      op = Operation.where(account: ka)
      op = op.where('recorded_at > ?', from) if from.present?
      op = op.where('recorded_at < ?', to) if to.present?
      op.sum(:credit)
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
