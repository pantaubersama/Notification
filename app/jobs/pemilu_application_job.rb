class PemiluApplicationJob < ActiveJob::Base
  # Set the Queue as Default
  queue_as :pemilu
end
