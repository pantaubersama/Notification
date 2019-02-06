class API::V1::Dashboard::Notifications::Resources::Notifications < API::V1::ApplicationResource
  helpers API::V1::Helpers
  resources "notifications" do
    before do
      authorize_admin!
    end

    desc "list broadcast" do
      headers AUTHORIZATION_HEADERS
      detail "list broadcast"
    end
    params do
      optional :title, type: String, desc: "Title Notification"
    end
    paginate per_page: Pagy::VARS[:items], max_per_page: Pagy::VARS[:max_per_page]
    oauth2
    get do
      resources = paginate(NotificationLog.where("data like ?", "%#{params.title}%"))
      present :notifications, resources, with: API::V1::Dashboard::Notifications::Entities::Notification
      present_metas resources
    end
  end
end
