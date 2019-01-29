class API::V1::Dashboard::Broadcasts::Resources::Broadcasts < API::V1::ApplicationResource

  resource "broadcasts" do
    desc "Publish Broadcasts"
    params do
      requires :title, type: String
      requires :description, type: String
      requires :link, type: String
      requires :event_type, type: String, values: ["info", "event"]
    end
    post do
      broadcast = PemiluBroadcast.new(params)
      unless broadcast.save
        error!(broadcast.errors.full_messages.join(", "), 422)
      end
      present :broadcast, broadcast, with: API::V1::Dashboard::Broadcasts::Entities::Broadcast
    end
  end
end
