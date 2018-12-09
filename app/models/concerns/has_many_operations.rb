module HasManyOperations
  extend ActiveSupport::Concern

  included do
    has_many :operations, as: :account
  end

  def balance(from: nil, to: nil)
    op = operations.all
    op = op.where('recorded_at > ?', from) if from.present?
    op = op.where('recorded_at < ?', to) if to.present?
    op.sum('credit - debit')
  end
end
