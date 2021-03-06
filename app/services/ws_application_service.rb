class WsApplicationService
  attr_accessor :resource, :notification

  def initialize(resource = nil)
    @resource     = resource
    @payload      = {}
    @notification = {
      notification: {
        title: "Wordstadium",
        body:  "[Challenge] Kick from ... "
      }
    }
    @results      = []
  end

  def push(notif_type = "", event_type = "", registration_ids = { "android" => [], "ios" => [] }, data = {}, broadcast_type, topic_target)
    build_android_paylod(notif_type, event_type, registration_ids, data, broadcast_type, topic_target)
    build_ios_paylod(notif_type, event_type, registration_ids, data, broadcast_type, topic_target)
    #build_notification_log(notif_type, event_type, registration_ids, @payload, false, broadcast_type)
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

  private
  def build_notification_log(notif_type, event_type, registration_ids, payload, is_action = false, broadcast_type = :using_topic)
    results = []
    if broadcast_type.eql?(:using_topic)
      results << {
        title:          @notification[:notification][:title],
        body:           @notification[:notification][:body],
        user_id:        nil,
        notif_type:     notif_type,
        event_type:     event_type,
        broadcast_type: broadcast_type,
        data:           payload,
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
          data:           payload,
          is_action:      is_action
        }
      end
    end
    NotificationLog.create!(results)
  end
  def build_android_paylod(notif_type, event_type, registration_ids, data, broadcast_type, topic_target)
    if [:using_topic, :using_ids].include?(broadcast_type)
      results = { content_available: true }
      # topic or ids
      if broadcast_type.eql?(:using_ids)
        if registration_ids["android"].present?
          results = results.merge({ registration_ids: (registration_ids["android"]).pluck(:content) })
        end
      elsif broadcast_type.eql?(:using_topic)
        results = results.merge({ to: "/topics/android-#{topic_target}" })
      end
      @payload[:payload] = data.merge({ notif_type: notif_type, event_type: event_type })
      @payload           = @payload.merge({ notif_type: notif_type, event_type: event_type })
      results            = results.merge(data: @payload)
      options            = {
        priority: "high",
      }
      response           = $fcm.push(results.merge(options))
      print "#{response.header}"
      @results << { response: response.json, app_type: :android }
    end
  rescue StandardError => errors
    print "---> #{errors}"
    @results << { response: { message: :errors }, app_type: :android }
  end

  def build_ios_paylod(notif_type, event_type, registration_ids, data, broadcast_type, topic_target)
    if [:using_topic, :using_ids].include?(broadcast_type)
      results = { content_available: true }.merge(@notification)
      # topic or ids
      if broadcast_type.eql?(:using_ids)
        if registration_ids["ios"].present?
          results = results.merge({ registration_ids: (registration_ids["ios"]).pluck(:content) })
        end
      elsif broadcast_type.eql?(:using_topic)
        results = results.merge({ to: "/topics/ios-#{topic_target}" })
      end
      @payload[:payload] = data.merge({ notif_type: notif_type, event_type: event_type })
      @payload           = @payload.merge({ notif_type: notif_type, event_type: event_type })
      results            = results.merge(data: @payload)
      options            = {
        priority: "high",
      }
      response           = $fcm.push(results.merge(options))
      print "#{response.header}"
      @results << { response: response.json, app_type: :ios }
    end
  rescue StandardError => errors
    print "---> #{errors}"
    @results << { response: { message: :errors }, app_type: :ios }
  end
end
