module API::V1
  module Entities
    class Balances < Grape::Entity
      expose :balance,
              documentation: {
                desc: 'Current User Balance in base currency.',
                type: BigDecimal
              }
      expose :nickname,
             documentation: {
               desc: 'User nickname.',
               type: String
             }
      expose(:income,
             documentation: {
               desc: 'User income info',
               type: Entities::AccountBalance
             }) do |balances, _options|
                  Entities::AccountBalance.represent OpenStruct.new(balances[:income])
                end

      expose(:expense,
             documentation: {
               desc: 'User expense info',
               type: Entities::AccountBalance
             }) do |balances, _options|
                  Entities::AccountBalance.represent OpenStruct.new(balances[:expense])
                end
    end
  end
end
