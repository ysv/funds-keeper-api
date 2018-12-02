module API::V1
  class Timestamp < Grape::API
    desc 'Get server current unix timestamp.'
    get "/time" do
      ts = ::Time.now.to_i
      {time: ts}
    end
  end
end