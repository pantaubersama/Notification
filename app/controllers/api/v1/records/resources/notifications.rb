class API::V1::Records::Resources::Notifications < API::V1::ApplicationResource
  helpers API::V1::Helpers

  resource "records" do
    desc "List", headers: AUTHORIZATION_HEADERS
    oauth2
    paginate per_page: Pagy::VARS[:items], max_per_page: Pagy::VARS[:max_per_page]
    get "notification" do
      resources = paginate(NotificationLog.where("user_id  IS NULL OR user_id = ? ", current_user.id).order("created_at DESC"))
      present :notifications, resources, with: API::V1::Records::Entities::Notification
      present_metas resources
    end
  end
end
