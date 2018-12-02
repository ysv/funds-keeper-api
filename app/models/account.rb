class Account < ApplicationRecord
  self.abstract_class = true

  has_many :operations

  def balance
    operations.sum('credit - debit')
  end
end
