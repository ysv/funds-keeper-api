# encoding: UTF-8
# frozen_string_literal: true

module API::V1
  module Auth
    module Utils
      class << self
        def jwt_public_key
          Rails.configuration.x.jwt_public_key
        end
      end
    end
  end
end
