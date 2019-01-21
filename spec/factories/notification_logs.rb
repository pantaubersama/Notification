FactoryBot.define do
  factory :notification_log do
    title { "MyString" }
    body { "MyText" }
    user_id { "" }
    notif_type { "MyString" }
    event_type { "MyString" }
    readed_at { "2019-01-21 10:44:02" }
    is_action { false }
  end
end
