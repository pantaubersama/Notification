class NotificationLog < ApplicationRecord
  enum receiver_type: { single: 1, multiple: 0 }
  belongs_to :user, optional: true
  serialize :data
  before_save :set_default_data

  private

  def set_default_data
    self.data = {}
  end
end

