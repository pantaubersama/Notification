class API::V1::Dashboard::Broadcasts::Resources::Broadcasts < API::V1::ApplicationResource
  helpers API::V1::Helpers
  resource "broadcasts" do
    desc "Publish Broadcasts", headers: AUTHORIZATION_HEADERS
    params do
      requires :title, type: String
      requires :description, type: String
      requires :link, type: String
      requires :event_type, type: String, values: ["info", "event"]
    end
    oauth2
    post do
      authorize_admin!
      broadcast = PemiluBroadcast.new(params)
      unless broadcast.save
        error!(broadcast.errors.full_messages.join(", "), 422)
      end
      present :pemilu_broadcast, broadcast, with: API::V1::Dashboard::Broadcasts::Entities::Broadcast
    end
  end
end
