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

  def push(notif_type = "", event_type = "", registration_ids = { "android" => [], "ios" => [] }, data = {})
    if registration_ids["android"].present?
      build_android_paylod(notif_type, event_type, registration_ids, data)
    end
    if registration_ids["ios"].present?
      build_ios_paylod(notif_type, event_type, registration_ids, data)
    end
  end

  def registration_ids(user_ids)
    uids = [user_ids].flatten
    fk   = []
    if user_ids.present?
      fk = FirebaseKey.where(user_id: uids).group_by_key_type
    end
    fk
  end

  private

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
