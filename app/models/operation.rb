class Operation < ApplicationRecord
  attribute :recorded_at, :datetime, default: -> { Time.now }

  validates :debit, :credit, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :account, polymorphic: true
  belongs_to :parent, polymorphic: true
  before_validation(on: :create) { self.recorded_at = parent.recorded_at }
end

# == Schema Information
# Schema version: 20181202211259
#
# Table name: operations
#
#  id           :bigint(8)        not null, primary key
#  account_type :string(255)      not null
#  account_id   :bigint(8)        not null
#  parent_type  :string(255)      not null
#  parent_id    :bigint(8)        not null
#  debit        :decimal(12, 2)   default(0.0), not null
#  credit       :decimal(12, 2)   default(0.0), not null
#  recorded_at  :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_operations_on_account_type_and_account_id  (account_type,account_id)
#  index_operations_on_parent_type_and_parent_id    (parent_type,parent_id)
#
