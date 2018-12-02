module API
  class Base < Grape::API
    PATH = 'api'

    route :any, '*path' do
      error! 'Route is not found', 404
    end

    mount API::V1::Base
  end
end