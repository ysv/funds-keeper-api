module API::V1
  module Helpers
    def uid
      env['api_v2.authentic_member_uid'] \
        || raise(Peatio::Auth::Error, 'Authentication failed.')
    end
  end
end