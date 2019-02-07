class API::V1::Dashboard::Notifications::Routes < Grape::API
  # Format response
  formatter :json, ::API::SuccessFormatter
  error_formatter :json, ::API::ErrorFormatter

  mount API::V1::Dashboard::Notifications::Resources::Notifications
end
