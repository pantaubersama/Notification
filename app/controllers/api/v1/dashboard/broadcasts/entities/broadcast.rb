class API::V1::Dashboard::Broadcasts::Entities::Broadcast < Grape::Entity
  expose :id
  expose :title
  expose :description
  expose :event_type
end
