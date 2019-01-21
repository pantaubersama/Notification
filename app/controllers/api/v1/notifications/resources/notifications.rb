class API::V1::Notifications::Resources::Notifications < API::V1::ApplicationResource
  helpers API::V1::Helpers

  resource "notifications" do
    desc "push"
    params do
      requires :registration_ids, type: Array[String], desc: "[registration_id, registration_id_1, ..]"
      requires :event_tye, type: String, desc: "message_chat"
      requires :messages, type: Hash, coerce_with: JSON do
        requires :title, type: String, desc: "Alam Ybs"
        requires :body, type: String, desc: "Mengirimkan pesan 'Hai Cuk'"
      end
      requires :resources, type: Hash, coerce_with: JSON do
        requires :id, type: String, desc: "4074fd9f-4e67-4cfe-a4a3-a15f682121db"
        requires :type, type: String, desc: "Message"
        requires :server, type: String, values: ["pemilu", "word_stadium", "auth"]
      end
    end
    get "multiple" do
      results = { version: "v1" }
      present results
    end
  end
end
