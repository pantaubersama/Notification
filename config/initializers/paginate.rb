require 'pagy/extras/array'
require 'pagy/extras/items'
Pagy::VARS[:max_per_page] = 500
Pagy::VARS[:items]        = 100
ApiPagination.configure do |config|
  # If you have both gems included, you can choose a paginator.
  config.paginator = :kaminari # or :will_paginate or :kaminari

  # Optional: what parameter should be used to set the page option
  config.page_param = :page

  # Optional: what parameter should be used to set the per page option
  config.per_page_param = :per_page
end