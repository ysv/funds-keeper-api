module API::V1
  class Base < Grape::API
    version 'v1', using: :path

    cascade false

    format         :json
    content_type   :json, 'application/json'
    default_format :json

    do_not_route_options!

    rescue_from(ActiveRecord::RecordNotFound) do |_e|
      error!('Record is not found', 404)
    end

    rescue_from(Grape::Exceptions::ValidationErrors) do |error|
      error!(error.message, 400)
    end

    rescue_from(:all) do |error|
      Rails.logger.error "#{error.class}: #{error.message}"
      binding.pry
      error!('Something went wrong', 500)
    end

    mount Timestamp
  end
end