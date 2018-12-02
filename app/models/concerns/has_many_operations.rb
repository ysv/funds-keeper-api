module HasManyOperations
  extend ActiveSupport::Concern

  included do
    has_many :operations, as: :account
  end

  def balance
    operations.sum('credit - debit')
  end
end
