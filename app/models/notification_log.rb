class NotificationLog < ApplicationRecord
  enum receiver_type: { single: 1, multiple: 0 }
  belongs_to :user, optional: true
end
