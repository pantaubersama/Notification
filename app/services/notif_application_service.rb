class NotifApplicationService
  attr_accessor :resource, :notification

  def initialize(resource = nil)
    @resource     = resource
    @notification = {
      notification: {
        title: "Pantau Bersama",
        body:  "[Pantau] Body belum di tambahkan"
      }
    }
  end

  def push(notif_type = "", event_type = "", registration_ids = { "android" => [], "ios" => [] }, data = {}, receiver_type)
    if registration_ids["android"].present?
      build_android_paylod(notif_type, event_type, registration_ids, data)
    end
    if registration_ids["ios"].present?
      build_ios_paylod(notif_type, event_type, registration_ids, data)
    end
    build_notification_log(notif_type, event_type, registration_ids, data, false, receiver_type)
  end

  def registration_ids(user_ids)
    uids = [user_ids].flatten
    fk   = []
    if ["all", :all].include?(uids)
      fk = FirebaseKey.group_by_key_type
    else
      if user_ids.present?
        fk = FirebaseKey.where(user_id: uids).group_by_key_type
      end
    end
    fk

  end

  private

  def build_notification_log(notif_type, event_type, registration_ids, data, is_action = false, receiver_type = :single)
    results = []
    registration_ids["android"].pluck(:user_id).each do |uid|
      results << {
        title:         @notification[:notification][:title],
        body:          @notification[:notification][:body],
        user_id:       uid,
        notif_type:    notif_type,
        event_type:    event_type,
        receiver_type: receiver_type,
        data:          data,
        is_action:     is_action
      }
    end
    NotificationLog.create!(results)
  end

  def build_android_paylod(notif_type, event_type, registration_ids, data)
    results = { content_available: true }
    if registration_ids["android"].present?
      results = results.merge({ registration_ids: registration_ids["android"].pluck(:content) })
    end
    if data.present?
      results = results.merge({ data: { notif_type: notif_type, event_type: event_type, payload: data } })
    end
    options  = {
      priority: "high",
    }
    response = $fcm.push(results.merge(options))
    Hashie::Mash.new({ response: response.json, headers: response.headers })
  end

  def build_ios_paylod(notif_type, event_type, registration_ids, data)
    results = { content_available: true }.merge(@notification)
    if registration_ids["ios"].present?
      results = results.merge({ registration_ids: registration_ids["ios"].pluck(:content) })
    end
    if data.present?
      results = results.merge({ data: { notif_type: notif_type, event_type: event_type, payload: data } })
    end
    options = {
      priority: "high",
    }

    response = $fcm.push(results.merge(options))
    Hashie::Mash.new({ response: response.json, headers: response.headers })
  end

end
