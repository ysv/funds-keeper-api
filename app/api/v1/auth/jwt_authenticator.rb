# encoding: UTF-8
# frozen_string_literal: true

module API::V1
  module Auth
    class JWTAuthenticator
      def initialize(token)
        @token = token
      end

      #
      # Decodes and verifies JWT.
      # Returns authentic member email or raises an exception.
      #
      # @param [Hash] options
      # @return [String, Member, NilClass]
      def authenticate!
        payload, header = Peatio::Auth::JWTAuthenticator
                              .new(Utils.jwt_public_key)
                              .authenticate!(@token)

        payload.fetch(:nickname)
      rescue => e
        if Peatio::Auth::Error === e
          raise e
        else
          raise Peatio::Auth::Error, e.inspect
        end
      end

      #
      # Exception-safe version of #authenticate!.
      #
      # @return [String, Member, NilClass]
      def authenticate(*args)
        authenticate!(*args)
      rescue
        nil
      end
    end
  end
end
