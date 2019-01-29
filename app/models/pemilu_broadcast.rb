class PemiluBroadcast < ApplicationRecord
  enum event_type: { info: 0, event: 1 }
  after_create :publish_notificaion

  private

  def publish_notificaion
    BroadcastsService.new.when_publish_event(self.id)
  end
end
