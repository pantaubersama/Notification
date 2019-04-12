class API::V1::Records::Resources::Notifications < API::V1::ApplicationResource
  helpers API::V1::Helpers

  resource "records" do
    desc "List", headers: AUTHORIZATION_HEADERS
    params do
      optional :filter_by, type: String, values: ["all", "wordstadium", "event"], default: "all", desc: "Title Broadcast"
    end
    oauth2
    paginate per_page: Pagy::VARS[:items], max_per_page: Pagy::VARS[:max_per_page]
    get "notification" do
      filter_by = ["broadcasts", "profile", "question", "badge", "quiz"]
      if params.filter_by.present?
        if params.filter_by.eql?("wordstadium")
          filter_by = ["challenge", "wordstadium"]
        elsif params.filter_by.eql?("event")
          filter_by = ["broadcasts"]
        end
      end
      if params.filter_by.eql?("event")
        resources = paginate(NotificationLog.where("user_id  IS NULL OR user_id = ? ", current_user.id).where(notif_type: filter_by, event_type: :event).order("created_at DESC"))
      else
        resources = paginate(NotificationLog.where("user_id  IS NULL OR user_id = ? ", current_user.id).where(notif_type: filter_by).order("created_at DESC"))
      end
      present :notifications, resources, with: API::V1::Records::Entities::Notification
      present_metas resources
    end
  end
end
