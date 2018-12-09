module API::V1
 module Entities
   class KeepAccount < Grape::Entity
     expose :name,
            documentation: {
              desc: 'Account Name',
              type: String,
            }

     expose :base_currency,
            documentation: {
              desc: 'Account Base Currency',
              type: String,
            }

     expose :balance,
            documentation: {
              desc: 'Account Current Balance',
              type: BigDecimal,
            }
   end
 end
end
