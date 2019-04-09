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
