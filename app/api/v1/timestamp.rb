module API::V1
  class Timestamp < Grape::API
    desc 'Get server current unix timestamp.'
    get "/timestamp" do
      { time: ::Time.now.to_i }
    end
  end
end