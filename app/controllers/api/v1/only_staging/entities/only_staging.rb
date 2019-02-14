class API::V1::OnlyStaging::Entities::OnlyStaging < Grape::Entity
  expose :id
  expose :notification do
    expose :title
    expose :body
  end
  expose :is_action
  expose :data
end
