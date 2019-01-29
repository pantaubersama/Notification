class API::V1::Records::Resources::Notifications < API::V1::ApplicationResource
  helpers API::V1::Helpers

  resource "records" do
    desc "List", headers: AUTHORIZATION_HEADERS
    oauth2
    get "notification" do
      logs = NotificationLog.where("user_id  IS NULL OR user_id = ? ", current_user.id)
      present :notifications, logs, with: API::V1::Records::Entities::Notification
    end
  end
end
