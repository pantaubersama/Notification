class API::V1::Dashboard::Broadcasts::Entities::Broadcast < Grape::Entity
  expose :id
  expose :title
  expose :description
  expose :event_type
  expose :created_at
  expose :created_at_in_word
end
