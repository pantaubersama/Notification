class API::V1::Dashboard::Notifications::Entities::Notification < Grape::Entity
  expose :id
  expose :title
  expose :body
  expose :user
  expose :data
  expose :created_at
end
