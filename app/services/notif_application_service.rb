class NotifApplicationService
  attr_accessor :resource, :notification

  def initialize(resource)
    @resource     = resource
    @notification = {
      notification: {
        title: "[Pantau] Title belum di tambahkan",
        body:  "[Pantau] Body belum di tambahkan"
      }
    }
  end

  def push(notif_type = "", event_type = "", registration_ids = {}, data = {})
    if registration_ids[:android].present?
      build_android_paylod(notif_type, event_type, registration_ids, data)
    end
    if registration_ids[:android].present?
      build_ios_paylod(notif_type, event_type, registration_ids, data)
    end
  end

  def registration_ids(user_ids)
    user_ids = Array.new(user_ids).flatten
    if user_ids.present?
      DeviceRegistration.where(user_id: user_ids).group_by_device_type
    else
      []
    end
  end

  private

  def build_android_paylod(notif_type, event_type, registration_ids, data)
    results = { content_available: true }
    if registration_ids["android"].present?
      results = results.merge({ registration_ids: registration_ids["android"].pluck(:device_token) })
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
      results = results.merge({ registration_ids: registration_ids["ios"].pluck(:device_token) })
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
