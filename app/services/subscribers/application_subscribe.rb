module Subscribers
  class ApplicationSubscribe
    include Sneakers::Worker
    def json_response params
      ActiveSupport::HashWithIndifferentAccess.new(JSON(params))
    end
  end
end
