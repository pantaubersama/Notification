module API
  module V1
    class ApplicationResource < Grape::API
      # Pagination
      # paginate per_page: 100, max_per_page: 500

      AUTHORIZATION_HEADERS = { Authorization: { description: 'Access Token', required: true } }.freeze
    end
  end
end
