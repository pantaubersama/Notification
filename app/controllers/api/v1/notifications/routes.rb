module API
  module V1
    module Notifications
      class Routes < Grape::API
        # Format response
        formatter :json, ::API::SuccessFormatter
        error_formatter :json, ::API::ErrorFormatter

        mount API::V1::Notifications::Resources::Notifications
      end
    end
  end
end
