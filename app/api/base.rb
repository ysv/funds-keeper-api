module API
  class Base < Grape::API
    PATH = 'api'

    cascade false

    mount API::V1::Base
  end
end