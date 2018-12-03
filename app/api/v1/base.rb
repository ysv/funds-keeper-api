module API::V1
  class Base < Grape::API
    version 'v1', using: :path

    cascade false

    format         :json
    content_type   :json, 'application/json'
    default_format :json

    do_not_route_options!

    use Auth::Middleware
    helpers API::V1::Helpers

    rescue_from(ActiveRecord::RecordNotFound) do |_e|
      error!('Record is not found', 404)
    end

    rescue_from(Grape::Exceptions::ValidationErrors) do |error|
      error!(error.message, 400)
    end

    rescue_from(:all) do |error|
      Rails.logger.error "#{error.class}: #{error.message}"
      error!('Something went wrong', 500)
    end
    mount Timestamp
    mount Account
    mount Income
    mount Rates
    mount Expense
    mount Balance

    # The documentation is accessible at http://localhost:3000/api/v1/swagger
    add_swagger_documentation base_path:   'v1',
                              mount_path:  '/swagger',
                              api_version: 'v1'

  end
end