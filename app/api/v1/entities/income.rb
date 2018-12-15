module API::V1
  module Entities
    class Income < Grape::Entity
      expose :base_amount,
             as: :amount,
             documentation: {
               desc: 'Income Amount.',
               type: String,
             }

      expose :base_currency,
             as: :currency,
             documentation: {
               desc: 'Income Currency.',
               type: String,
             }

      expose(:keep_account,
             documentation: {
               desc: 'Keep Account Name.',
               type: String
             }) { |income| income.keep_account.name }

      expose :description,
             documentation: {
               desc: 'Income Transaction description.',
               type: String
             }

      # TODO: Check that it's String.
      expose :recorded_at,
             documentation: {
               desc: 'Income Transaction date',
               type: String
             }
    end
  end
end
