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

    desc "list broadcast" do
      headers AUTHORIZATION_HEADERS
      detail "list broadcast"
    end
    params do
      optional :title, type: String, desc: "Title Broadcast"
    end
    paginate per_page: Pagy::VARS[:items], max_per_page: Pagy::VARS[:max_per_page]
    oauth2
    get do
      authorize_admin!
      resources = paginate(PemiluBroadcast.where("title like ?", "%#{params.title}%").order("created_at DESC"))
      present :notifications, resources, with: API::V1::Dashboard::Broadcasts::Entities::Broadcast
      present_metas resources
    end

    desc "show detail broadcast" do
      headers AUTHORIZATION_HEADERS
      detail "show detail broadcast"
    end
    oauth2
    get '/:id' do
      authorize_admin!
      present :notification, PemiluBroadcast.find(params[:id]), with: API::V1::Dashboard::Broadcasts::Entities::Broadcast
    end
  end
end
