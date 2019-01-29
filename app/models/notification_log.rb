class NotificationLog < ApplicationRecord
  enum broadcast_type: { using_ids: 1, using_topic: 0 }
  belongs_to :user, optional: true
  serialize :data
  before_save :set_default_data

  private

  def set_default_data
    self.data = {}
  end
end

