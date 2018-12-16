module API::V1
  module Entities
    class AccountBalance < Grape::Entity
      expose :month,
             documentation: {
               desc: 'Account month cash flow',
               type: BigDecimal
             }
      expose :total,
             documentation: {
               desc: 'Account total cash flow',
               type: BigDecimal
             }
    end
  end
end
