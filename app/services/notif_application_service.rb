class NotifApplicationService
  attr_accessor :resource, :notification

  def initialize(resource = nil)
    @resource     = resource
    @resource     = nil
    @notification = {
      notification: {
        title: "Pantau Bersama",
        body:  "[Pantau] Body belum di tambahkan"
      }
    }
  end

  def push(notif_type = "", event_type = "", registration_ids = { "android" => [], "ios" => [] }, data = {}, broadcast_type)
    build_sender_paylod(notif_type, event_type, registration_ids, data, broadcast_type)
    build_notification_log(notif_type, event_type, registration_ids, data, false, broadcast_type)
    @results
  end

  def registration_ids(user_ids)
    uids = [user_ids].flatten
    if user_ids.present?
      fk = FirebaseKey.where(user_id: uids).group_by_key_type
    else
      fk = {}
    end
    fk
  end


  def build_notification_log(notif_type, event_type, registration_ids, data, is_action = false, broadcast_type = :using_topic)
    results = []
    if broadcast_type.eql?(:using_topic)
      results << {
        title:          @notification[:notification][:title],
        body:           @notification[:notification][:body],
        user_id:        nil,
        notif_type:     notif_type,
        event_type:     event_type,
        broadcast_type: broadcast_type,
        data:           data,
        is_action:      is_action
      }
    elsif broadcast_type.eql?(:using_ids)
      (registration_ids["ios"].pluck(:user_id) + registration_ids["android"].pluck(:user_id)).uniq.each do |uid|
        results << {
          title:          @notification[:notification][:title],
          body:           @notification[:notification][:body],
          user_id:        uid,
          notif_type:     notif_type,
          event_type:     event_type,
          broadcast_type: broadcast_type,
          data:           data,
          is_action:      is_action
        }
      end
    end
    NotificationLog.create!(results)
  end

  def build_sender_paylod(notif_type, event_type, registration_ids, data, broadcast_type)
    if [:using_topic, :using_ids].include?(broadcast_type)
      results = { content_available: true }.merge(@notification)

      # topic or ids
      if broadcast_type.eql?(:using_ids)
        if registration_ids["android"].present? || registration_ids["ios"].present?
          results = results.merge({ registration_ids: (registration_ids["ios"] + registration_ids["android"]).pluck(:content) })
        end
      elsif broadcast_type.eql?(:using_topic)
        results = results.merge({ to: "/topics/#{notif_type}-#{event_type}" })
      end
      results  = results.merge({ data: { notif_type: notif_type, event_type: event_type, payload: data } })
      options  = {
        priority: "high",
      }
      response = $fcm.push(results.merge(options))
      print "#{response}"
      @results = Hashie::Mash.new({ response: response.json, headers: response.headers })
    end

  end
end
