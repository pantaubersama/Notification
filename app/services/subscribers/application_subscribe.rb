module Subscribers
  class ApplicationSubscribe
    def json_response params
      ActiveSupport::HashWithIndifferentAccess.new(JSON(params))
    end
  end
end
