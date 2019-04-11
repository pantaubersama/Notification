class API::V1::Dashboard::Notifications::Resources::Notifications < API::V1::ApplicationResource
  helpers API::V1::Helpers
  resources "notifications" do
    before do
      authorize_admin!
    end

    desc "list notification log" do
      headers AUTHORIZATION_HEADERS
      detail "list notification log"
    end
    params do
      optional :title, type: String, desc: "Title Notification Log"
    end
    paginate per_page: Pagy::VARS[:items], max_per_page: Pagy::VARS[:max_per_page]
    oauth2
    get do
      resources = paginate(NotificationLog.where("data like ?", "%#{params.title}%").order("created_at DESC"))
      present :notifications, resources, with: API::V1::Dashboard::Notifications::Entities::Notification
      present_metas resources
    end

    desc "show detail notification log" do
      headers AUTHORIZATION_HEADERS
      detail "show detail notification log"
    end
    oauth2
    get '/:id' do
      present :notification, NotificationLog.find(params[:id]), with: API::V1::Dashboard::Notifications::Entities::Notification
    end

  end
end
