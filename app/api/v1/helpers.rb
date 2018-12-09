module API::V1
  module Helpers
    def uid
      env['api_v2.authentic_member_uid']
        raise Peatio::Auth::Error, 'Cant fetch nickname'
    end
  end
end