module Faker
  class Auth
    class << self
      def uid
        "ID#{SecureRandom.hex(5).upcase}"
      end
    end
  end
end
